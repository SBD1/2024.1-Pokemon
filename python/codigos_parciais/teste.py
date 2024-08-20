import pygame
import sys
import psycopg2
from tabulate import tabulate

# Configurações do banco de dados
DB_HOST = '172.19.0.2'
DB_NAME = 'db_pokemon'
DB_USER = 'pokemon'
DB_PASSWORD = '123456'

# Conectar ao banco de dados
conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, port=5434)
cursor = conn.cursor()

# Dicionários de tipos e cores de Pokémon
tipo_traducao = {
    'fire': 'Fogo', 'water': 'Água', 'grass': 'Grama', 'electric': 'Elétrico',
    'ground': 'Terra', 'rock': 'Pedra', 'ice': 'Gelo', 'psychic': 'Psíquico',
    'dark': 'Sombrio', 'fairy': 'Fada', 'dragon': 'Dragão', 'ghost': 'Fantasma',
    'bug': 'Inseto', 'flying': 'Voador', 'steel': 'Aço', 'fighting': 'Lutador',
    'poison': 'Veneno', 'normal': 'Normal'
}

cor_tipo = {
    'fire': '\033[41m', 'water': '\033[44m', 'grass': '\033[42m', 'electric': '\033[43m',
    'ground': '\033[48;5;94m', 'rock': '\033[48;5;237m', 'ice': '\033[46m',
    'psychic': '\033[45m', 'dark': '\033[48;5;235m', 'fairy': '\033[48;5;209m',
    'dragon': '\033[48;5;18m', 'ghost': '\033[48;5;57m', 'bug': '\033[48;5;22m',
    'flying': '\033[48;5;14m', 'steel': '\033[48;5;244m', 'fighting': '\033[41m',
    'poison': '\033[45m', 'normal': '\033[37m', 'reset': '\033[0m'
}

# Funções do banco de dados para criar jogador e obter diálogos
def get_narrator_dialogue():
    cursor.execute("SELECT fala FROM dialogo WHERE personagem = 'Narrador' ORDER BY ordem")
    dialogues = cursor.fetchall()
    if not dialogues:
        print("Nenhuma fala encontrada para o narrador.")
    for dialogue in dialogues:
        print(dialogue[0])
        input("Pressione Enter para continuar...")

def check_existing_player():
    cursor.execute("SELECT COUNT(*) FROM jogador")
    count = cursor.fetchone()[0]
    return count > 0

def list_pokemon():
    cursor.execute("SELECT id_pokemon, nome, tipo FROM pokemon_base WHERE evolui_de = 'None' AND evolui_para <> 'None'")
    pokemons = cursor.fetchall()
    tabela = []
    for pokemon in pokemons:
        tipo_pt = tipo_traducao.get(pokemon[2], pokemon[2])
        cor = cor_tipo.get(pokemon[2], cor_tipo['normal'])
        linha = [f"{cor}{pokemon[0]}{cor_tipo['reset']}", f"{cor}{pokemon[1]}{cor_tipo['reset']}", f"{cor}{tipo_pt}{cor_tipo['reset']}"]
        tabela.append(linha)
    print("Escolha o Pokémon que você quer ser:")
    print(tabulate(tabela, headers=["ID", "Nome", "Tipo"], tablefmt="grid"))
    return pokemons

def create_player(pokemon_id):
    cursor.execute("""
        SELECT nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base,
               velocidade_base, acuracia_base, evasao_base, status_base
        FROM pokemon_base WHERE id_pokemon = %s
    """, (pokemon_id,))
    pokemon_data = cursor.fetchone()
    if pokemon_data is None:
        print("Pokémon não encontrado.")
        return
    cursor.execute("INSERT INTO pokemon (id_tipo_pokemon) VALUES (1) RETURNING id_pokemon")
    new_pokemon_id = cursor.fetchone()[0]
    cursor.execute("""
        INSERT INTO jogador (nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, id_jogador, saldo, tam_inventario, posicao, tipo_elemental)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (1, pokemon_data[2], pokemon_data[3], pokemon_data[4],
          pokemon_data[5], pokemon_data[6], pokemon_data[7], pokemon_data[8],
          pokemon_data[9], pokemon_data[0], new_pokemon_id, 0, 20, 17902, pokemon_data[1]))
    cursor.execute("INSERT INTO instancia_item (id_item) VALUES (1) RETURNING id_instancia_item")
    id_instancia_item = cursor.fetchone()[0]
    cursor.execute("INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (%s, %s) RETURNING id_inventario", (new_pokemon_id, id_instancia_item))
    cursor.execute("INSERT INTO correio (jogador_id, terreno_id) VALUES (%s, %s)", (new_pokemon_id, 17903))
    conn.commit()
    print(f"Você agora é o Pokémon {pokemon_data[0]}!")

# Inicializar Pygame e começar o jogo
def initialize_pygame():
    pygame.init()
    return pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)

def fetch_terrains(player_id):
    query = """
    WITH jogador_posicao AS (
        SELECT posicao
        FROM jogador
        WHERE id_jogador = %s
    ),
    andar_atual AS (
        SELECT t.id_andar
        FROM terreno t
        JOIN jogador_posicao jp ON t.id_terreno = jp.posicao
    ),
    terrenos_no_andar AS (
        SELECT t.id_terreno, t.x, t.y, tt.descricao
        FROM terreno t
        JOIN tipo_terreno tt ON t.id_tipo_terreno = tt.id_tipo_terreno
        JOIN andar_atual aa ON t.id_andar = aa.id_andar
    )
    SELECT * FROM terrenos_no_andar;
    """
    cursor.execute(query, (player_id,))
    return cursor.fetchall()

def draw_terrains(surface, terrains):
    for (_, x, y, descricao) in terrains:
        if descricao == 'Parede':
            color = BLACK
        elif descricao == 'Água':
            color = BLUE
        elif descricao == 'Chão':
            color = BROWN
        elif descricao == 'Escada':
            color = GREY
        elif descricao == 'Árvore':
            color = DARK_GREEN
        elif descricao == 'Grama':
            color = LIGHT_GREEN
        else:
            color = WHITE
        rect_x, rect_y = x * square_size, y * square_size
        pygame.draw.rect(surface, color, (rect_x, rect_y, square_size, square_size))

def get_terreno_id(x, y):
    query = """
    SELECT id_terreno
    FROM terreno
    WHERE x = %s AND y = %s
    """
    cursor.execute(query, (x, y))
    result = cursor.fetchone()
    return result[0] if result else None

# Configurações de cores e do mapa
WHITE, BLACK, BLUE, BROWN, GREY, LIGHT_GREEN, DARK_GREEN = (255, 255, 255), (0, 0, 0), (0, 0, 255), (139, 69, 19), (128, 128, 128), (144, 238, 144), (34, 139, 34)
square_size = 50
window_width, window_height = 800, 600

# Função principal
def main():
    if check_existing_player():
        choice = input("Já existe um progresso salvo. Deseja continuar com o jogador existente? (s/n): ").strip().lower()
        if choice != 's':
            get_narrator_dialogue()
            list_pokemon()
            global pokemon_id
            pokemon_id = int(input("Digite o número do Pokémon que deseja ser: "))
            create_player(pokemon_id)
    else:
        get_narrator_dialogue()
        list_pokemon()
        pokemon_id = int(input("Digite o número do Pokémon que deseja ser: "))
        create_player(pokemon_id)
    
    window = initialize_pygame()
    terrains = fetch_terrains(pokemon_id)
    revealed_surface = pygame.Surface((window_width, window_height))
    revealed_surface.fill(WHITE)
    draw_terrains(revealed_surface, terrains)

    running = True
    player_x, player_y = 0, 0
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_w:
                    player_y -= 50
                elif event.key == pygame.K_s:
                    player_y += 50
                elif event.key == pygame.K_a:
                    player_x -= 50
                elif event.key == pygame.K_d:
                    player_x += 50
                elif event.key == pygame.K_RETURN:
                    terreno_id = get_terreno_id(player_x // 50, player_y // 50)
                    if terreno_id is not None:
                        cursor.execute("SELECT descricao FROM tipo_terreno WHERE id_tipo_terreno = %s", (terreno_id,))
                        descricao = cursor.fetchone()[0]
                        if descricao == 'Escada':
                            print("Você subiu para o próximo andar.")
                            # Aqui pode-se implementar a lógica de mudar de andar

        window.fill(WHITE)
        window.blit(revealed_surface, (0, 0))
        pygame.draw.rect(window, (255, 0, 0), (player_x, player_y, square_size, square_size))
        pygame.display.update()

    pygame.quit()
    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
