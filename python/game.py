import pygame
import sys
from tabulate import tabulate
import psycopg2

# Configurações do banco de dados
DB_HOST = '172.19.0.2'
DB_NAME = 'db_pokemon'
DB_USER = 'pokemon'
DB_PASSWORD = '123456'

# Definições de cores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
BROWN = (139, 69, 19)
GREY = (128, 128, 128)
LIGHT_GREEN = (144, 238, 144)  # Grama verde clara
DARK_GREEN = (34, 139, 34)  # Árvore verde escura
YELLOW = (255, 255, 0)
LIGHT_BLUE = (173, 216, 230)  # Água clara
PURPLE = (160, 32, 240)
PINK = (255, 182, 193)
ORANGE = (255, 165, 0)
LIGHT_BROWN = (210, 180, 140)
DARK_GREY = (105, 105, 105)

# Mapeamento de cores para cada tipo de Pokémon
pokemon_type_colors = {
    "normal": GREY,
    "fire": RED,
    "water": BLUE,
    "electric": YELLOW,
    "grass": LIGHT_GREEN,
    "ice": LIGHT_BLUE,
    "fighting": BROWN,
    "poison": PURPLE,
    "ground": LIGHT_BROWN,
    "flying": LIGHT_BLUE,
    "psychic": PINK,
    "bug": DARK_GREEN,
    "rock": DARK_GREY,
    "ghost": (75, 0, 130),  # Índigo escuro
    "dragon": (0, 0, 139),  # Azul escuro
    "dark": BLACK,
    "steel": (192, 192, 192),  # Cinza claro
    "fairy": (255, 105, 180),  # Rosa choque
}

# Configurações do mapa
square_size = 50
map_size = 50  # O mapa é 50x50 quadrados

# Dimensões da superfície do mapa
movement_limit_width = map_size * square_size
movement_limit_height = map_size * square_size

# Dimensões da janela
window_width, window_height = 800, 600

# Função para conectar ao banco de dados
def connect_db():
    return psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, port=5434)

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

def pega_npc():
    cursor.execute("SELECT COUNT(*) FROM vendedor")


def select_existing_player():
    cursor.execute("SELECT id_jogador, nome FROM jogador")
    players = cursor.fetchall()
    tabela = []
    for player in players:
        id = player[0]
        jogador = player[1]
        linha = [f"{id}", f"{jogador}"]
        tabela.append(linha)
    print(tabulate(tabela, headers=["ID", "Jogador"],tablefmt="grid"))
    return players

def tipo_elemental_pokemon(id_jogador):
    cursor.execute("select tipo_elemental from jogador where id_jogador = %s",(id_jogador,))
    tipo = cursor.fetchone()[0]
    return tipo

def find_id_terreno(new_x, new_y, andar):
    if new_x >= 50:
        new_x = int(new_x / 50)
    if new_y >= 50:
        new_y = int(new_y / 50)
    
    cursor.execute("SELECT id_terreno FROM terreno where x = %s and y= %s and id_andar = %s", (new_x, new_y, andar))
    terreno = cursor.fetchone()[0]
    return terreno

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
    return new_pokemon_id

# Função para obter terrenos com base no andar atual
def fetch_terrains(player_id):
    conn = connect_db()
    cursor = conn.cursor()  # OBS1. Tem que fazer join com o mapa também a ordem seria mapa -> andar -> terreno
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
    terrains = cursor.fetchall()
    return terrains

def fetch_andar_map(player_id):
    conn = connect_db()
    cursor = conn.cursor()  # OBS1. Tem que fazer join com o mapa também a ordem seria mapa -> andar -> terreno
    query = """
        SELECT a.id_andar, a.nome_mapa
        FROM jogador j
        JOIN terreno te ON te.id_terreno = j.posicao
        JOIN andar a ON te.id_andar = a.id_andar
        WHERE j.id_jogador = %s;
    """
    cursor.execute(query, (player_id,))
    andar_mapa = cursor.fetchone()

    return andar_mapa

# Função para obter o próximo andar
def get_next_floor(current_floor):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT MAX(t.id_andar) FROM terreno t")
    max_floor = cursor.fetchone()[0]
    cursor.close()
    conn.close()
    return min(current_floor + 1, max_floor)  # Não exceder o andar máximo

# Função para inicializar o pygame
def initialize_pygame():
    pygame.init()
    return pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)

# Função para desenhar o jogador
def draw_player(surface, offset_x, offset_y, player_x, player_y, pokemon_type):
    color = pokemon_type_colors.get(pokemon_type, WHITE)  # Usa WHITE como padrão se o tipo não for encontrado
    pygame.draw.rect(surface, color, (player_x - offset_x, player_y - offset_y, square_size, square_size))

# Função para verificar colisão com obstáculos
def check_collision(x, y, terrains):
    player_rect = pygame.Rect(x, y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        terrain_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
        if player_rect.colliderect(terrain_rect) and descricao in ['Parede', 'Água', 'Árvore']:
            return True
    return False

# Função para verificar se o jogador está sobre a escada
def check_on_ladder(player_x, player_y, terrains):
    player_rect = pygame.Rect(player_x, player_y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        if descricao == 'Escada':
            ladder_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
            if player_rect.colliderect(ladder_rect):
                return True
    return False

# Função para desenhar os terrenos
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
            color = WHITE  # Cor padrão se a descrição não for reconhecida
        pygame.draw.rect(surface, color, (x * square_size, y * square_size, square_size, square_size))

# Função para mudar de andar
def change_floor(current_floor, terrains, revealed_surface):
    next_floor = get_next_floor(current_floor)
    if next_floor != current_floor:
        current_floor = next_floor
        terrains = fetch_terrains(player)
        revealed_surface.fill(WHITE)
        draw_terrains(revealed_surface, terrains)
        print(f"Subiu para o andar {current_floor}")
    return current_floor, terrains

# Função principal (main)
def main():
    global andar, mapa, player, tipo
    global window_width, window_height

    if check_existing_player():
        choice = input("Já existe um progresso salvo. Deseja continuar com o jogador existente? (s/n): ").strip().lower()
        if choice != 's':
            get_narrator_dialogue()
            list_pokemon()
            pokemon_id = int(input("Digite o número do Pokémon que deseja ser: "))
            player = create_player(pokemon_id)
            andar_mapa = fetch_andar_map(player)
            andar = 6
            mapa = 'Cidade'
            tipo = tipo_elemental_pokemon(player)
        else:
            select_existing_player()
            player = int(input("Qual jogo deseja continuar ? "))
            andar_mapa = fetch_andar_map(player)
            andar = andar_mapa[0]
            mapa = andar_mapa[1]
            tipo = tipo_elemental_pokemon(player)

    else:
        get_narrator_dialogue()
        list_pokemon()
        pokemon_id = int(input("Digite o número do Pokémon que deseja ser: "))
        player = create_player(pokemon_id)
        andar = 6
        mapa = 'Cidade'
        tipo = tipo_elemental_pokemon(player)

    # Inicialize o pygame
    window = initialize_pygame()

    # Variáveis do jogo
    current_floor = 1
    player_x, player_y = 0, 0
    terrains = fetch_terrains(player)

    # Criar uma superfície para o mapa
    revealed_surface = pygame.Surface((movement_limit_width, movement_limit_height))
    revealed_surface.fill(WHITE)

    # Desenhe todos os terrenos na superfície revelada
    draw_terrains(revealed_surface, terrains)

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.VIDEORESIZE:
                window_width, window_height = event.w, event.h
                window = initialize_pygame()
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    new_x = player_x - square_size
                    if not check_collision(new_x, player_y, terrains):
                        player_x = new_x
                elif event.key == pygame.K_RIGHT:
                    new_x = player_x + square_size
                    if not check_collision(new_x, player_y, terrains):
                        player_x = new_x
                elif event.key == pygame.K_UP:
                    new_y = player_y - square_size
                    if not check_collision(player_x, new_y, terrains):
                        player_y = new_y
                elif event.key == pygame.K_DOWN:
                    new_y = player_y + square_size
                    if not check_collision(player_x, new_y, terrains):
                        player_y = new_y
                new_terreno = find_id_terreno(player_x, player_y, andar)
                cursor.execute("UPDATE jogador SET posicao = %s WHERE id_jogador = %s", (new_terreno, player))
                conn.commit()

        # Verifique se o jogador está sobre a escada
        if check_on_ladder(player_x, player_y, terrains):
            current_floor, terrains = change_floor(current_floor, terrains, revealed_surface)
            player_x = 0
            player_y = 0

        # Limitar o movimento do jogador à área definida
        player_x = max(0, min(player_x, movement_limit_width - square_size))
        player_y = max(0, min(player_y, movement_limit_height - square_size))

        # Calcular o deslocamento da "câmera"
        offset_x = max(0, min(player_x - window_width // 2, movement_limit_width - window_width))
        offset_y = max(0, min(player_y - window_height // 2, movement_limit_height - window_height))

        # Preencher a janela
        window.fill(WHITE)

        # Desenhar a superfície de áreas reveladas com deslocamento
        window.blit(revealed_surface, (-offset_x, -offset_y))

        # Desenhar o jogador
        draw_player(window, offset_x, offset_y, player_x, player_y, tipo)
        #if mapa == 'Cidade':
        #    draw_npc()

        pygame.display.flip()

    pygame.quit()
    sys.exit()

if __name__ == '__main__':
    main()
