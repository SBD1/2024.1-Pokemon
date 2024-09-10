import pygame
import sys
from tabulate import tabulate
import psycopg2
import random

# Configurações do banco de dados
DB_HOST = 'localhost'
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
PURPLE_D = (150, 112, 180)
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

def fetch_vendedores():
    cursor.execute("""
        SELECT v.id_vendedor, t.x, t.y, v.tipo_elemental, v.nome
        FROM vendedor v
        JOIN terreno t ON v.posicao = t.id_terreno
    """)
    vendedores = cursor.fetchall()
    return vendedores

def fetch_inimigos(nome_mapa, id_andar):
    query = """
        SELECT i.id_inimigo, t.x, t.y, t.id_andar, a.nome_mapa, i.tipo_elemental, i.nome
        FROM inimigo i
        JOIN terreno t ON i.posicao = t.id_terreno
        JOIN andar a ON t.id_andar = a.id_andar
        WHERE nome_mapa = %s
        AND a.id_andar = %s;
    """
    cursor.execute(query, (nome_mapa, id_andar))
    inimigos = cursor.fetchall()
    return inimigos

def draw_inimigos(surface, offset_x, offset_y, inimigos):
    for _, vx, vy,_,_, pokemon_type,_ in inimigos:
        color = pokemon_type_colors.get(pokemon_type, GREY)
        pygame.draw.rect(surface, color, (vx * square_size - offset_x, vy * square_size - offset_y, square_size, square_size))

def draw_vendedores(surface, offset_x, offset_y, vendedores):
    for _, vx, vy, pokemon_type,_ in vendedores:
        color = pokemon_type_colors.get(pokemon_type, GREY)  # Use GREY if type is not found
        pygame.draw.rect(surface, color, (vx * square_size - offset_x, vy * square_size - offset_y, square_size, square_size))

def get_floor(player):
    cursor.execute("SELECT numero_andar FROM andar WHERE id_andar = (SELECT id_andar FROM terreno WHERE id_terreno = (SELECT posicao FROM jogador WHERE id_jogador = %s))", (player,))
    floor = cursor.fetchone()[0]
    return floor


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

def find_xy_terreno(player):

    cursor.execute("SELECT posicao FROM jogador where id_jogador = %s", (player,))
    terreno = cursor.fetchone()[0]
    
    cursor.execute("SELECT x, y FROM terreno where id_terreno = %s", (terreno,))
    terreno = cursor.fetchone()
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
    habilidades_por_tipo = {
    'normal': [6, 102], 
    'fire': [10, 55], 
    'water': [58, 59], 
    'grass': [25, 79], 
    'electric': [87, 90], 
    'fighting': [27, 29], 
    'ice': [61, 62], 
    'psychic': [96, 97], 
    'poison': [43, 54], 
    'rock': [91, 92], 
    'ground': [31, 94], 
    'dark': [47, 24], 
    'bug': [44, 84], 
    'dragon': [85, 66] 
    }
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
    """, (1, 1000, pokemon_data[3], pokemon_data[4],
          pokemon_data[5], pokemon_data[6], pokemon_data[7], pokemon_data[8],
          pokemon_data[9], pokemon_data[0], new_pokemon_id, 1000, 20, 6, pokemon_data[1]))
    cursor.execute("INSERT INTO instancia_item (id_item) VALUES (1) RETURNING id_instancia_item")
    id_instancia_item = cursor.fetchone()[0]
    cursor.execute("INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (%s, %s) RETURNING id_inventario", (new_pokemon_id, id_instancia_item))
    cursor.execute("INSERT INTO correio (id_correio, terreno_id) VALUES (%s, %s)", (new_pokemon_id, 4))
    cursor.execute("INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (%s, %s)", (new_pokemon_id, 4))
    cursor.execute("INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (%s, %s)", (new_pokemon_id, 101))
    if pokemon_data[1] in habilidades_por_tipo:
        for habilidade_id in habilidades_por_tipo[pokemon_data[1]]:
            cursor.execute("INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (%s, %s)", (new_pokemon_id, habilidade_id))
    conn.commit()
    print(f"Você agora é o Pokémon {pokemon_data[0]}!")
    return new_pokemon_id

# Função para obter terrenos com base no andar atual
def fetch_terrains(player_id):
    conn = connect_db()
    cursor = conn.cursor() 
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

def draw_player(surface, offset_x, offset_y, player_x, player_y, pokemon_type):
    color = pokemon_type_colors.get(pokemon_type, WHITE)    
    brown = (139, 69, 19)  # Cor marrom do corpo
    pink = (255, 182, 193)  # Rosa para orelhas e língua
    dark_pink = (200, 100, 120)  # Rosa escuro para detalhes
    black = (0, 0, 0)  # Cor preta para contorno
    white = (255, 255, 255)  # Branco para os olhos

    # Tamanho de cada pixel
    pixel_size = square_size // 8

    # Matriz que define a sprite do Pokémon
    sprite = [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 3, 4, 0, 0, 4, 3, 0],
        [0, 3, 4, 4, 4, 4, 3, 0],
        [0, 2, 4, 4, 4, 4, 2, 0],
        [0, 0, 5, 0, 0, 5, 0, 0],
        [0, 0, 0, 2, 2, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
    ]

    # Dicionário de cores associadas aos números na matriz
    colors = {
        0: color,
        1: brown,
        2: pink,
        3: dark_pink,
        4: black,
        5: white,
    }

    # Desenhar a sprite na superfície
    for y, row in enumerate(sprite):
        for x, color_id in enumerate(row):
            color = colors.get(color_id, black)
            pygame.draw.rect(surface, color, (
                player_x - offset_x + x * pixel_size,
                player_y - offset_y + y * pixel_size,
                pixel_size,
                pixel_size
            ))


# Função para verificar colisão com obstáculos
def check_collision(x, y, terrains, id_jogador):
    player_rect = pygame.Rect(x, y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        terrain_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
        if player_rect.colliderect(terrain_rect) and descricao in ['Parede', 'Água', 'Árvore']:
            return True
        elif player_rect.colliderect(terrain_rect) and descricao in ['Correio']:
            abre_correio(id_jogador)
            return True
    return False


def abre_correio(id_jogador):
    conn = connect_db()
    cursor = conn.cursor()

    query ="""
        SELECT 
            id_missao,
            objetivo,
            dificuldade,
            principal,
            nome_mapa
        FROM missao
    """

    cursor.execute(query, (id_jogador,))
    missoes = cursor.fetchall()


    # Preparar dados para tabulate
    headers = ["ID Missão", "Objetivo", "Dificuldade", "Tipo Missão", "Mapa"]
    table = [[missao[0], missao[1], 'Fácil', 'Principal', missao[4]] for missao in missoes]

    # Exibir tabela formatada
    print(tabulate(table, headers, tablefmt="grid"))

    escolha = int(input("Digite o número da missão que quer fazer: "))
    missao_ids = [missao[0] for missao in missoes]
    cursor.execute("SELECT im.id_missao, m.nome_mapa, m.objetivo FROM instancia_missao im JOIN missao m on im.id_missao = m.id_missao WHERE id_jogador = %s and concluida = 'false'", (id_jogador,))
    missoes_ativas = cursor.fetchall()
    if missoes_ativas:
        print("Você já tem uma missão ativa:")
        for missao in missoes_ativas:
            print(f"Missão {missao[0]} - {missao[2]} no mapa {missao[1]}")
        print("Finalize-a antes de pegar outra missão")
    else:
        if escolha in missao_ids:
            cursor.execute("INSERT INTO instancia_missao (id_missao, id_jogador, concluida) VALUES (%s, %s, %s);", (escolha, id_jogador, 'false'))
            conn.commit()
            print(f'Missão {escolha} selecionada!')
        else:
            print('Valor inválido!')

    cursor.close()
    conn.close()

def check_collision_vendedor(x, y, vendedores):
    player_rect = pygame.Rect(x, y, square_size, square_size)
    
    # Verificar colisão com vendedores
    for vendedor in vendedores:
        vendedor_rect = pygame.Rect(vendedor[1] * square_size, vendedor[2] * square_size, square_size, square_size)
        if player_rect.colliderect(vendedor_rect):
            interagir_com_vendedor(vendedor)
            return "vendedor", vendedor
    
    return None


def fetch_player_data(player_id):
    print(player_id)
    query = """
    SELECT vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, tipo_elemental
    FROM jogador
    WHERE id_jogador = %s;
    """
    cursor.execute(query, (player_id,))
    result = cursor.fetchone()
    if result:
        # Converter o resultado em um dicionário
        return {
            'vida': result[0],
            'ataque_fisico': result[1],
            'defesa_fisica': result[2],
            'ataque_especial': result[3],
            'velocidade': result[4],
            'acuracia': result[5],
            'evasao': result[6],
            'status': result[7],
            'nome': result[8],
            'tipo_elemental': result[9],
        }
    print(result)
    return None


def fetch_enemy_data(enemy_id):
    query = """
    SELECT vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, tipo_elemental
    FROM inimigo
    WHERE id_inimigo = %s;
    """
    cursor.execute(query, (enemy_id,))
    result = cursor.fetchone()
    if result:
        return {
            'vida': result[0],
            'ataque_fisico': result[1],
            'defesa_fisica': result[2],
            'ataque_especial': result[3],
            'velocidade': result[4],
            'acuracia': result[5],
            'evasao': result[6],
            'status': result[7],
            'nome': result[8],
            'tipo_elemental': result[9],
        }
    return None

def check_collision_inimigo(x, y, inimigos, player, revealed_surface):
    player_rect = pygame.Rect(x, y, square_size, square_size)
    
    # Verificar colisão com vendedores
    for inimigo in inimigos:
        inimigo_rect = pygame.Rect(inimigo[1] * square_size, inimigo[2] * square_size, square_size, square_size)
        if player_rect.colliderect(inimigo_rect):
            interagir_com_inimigo(inimigo, player, revealed_surface)
            return "vendedor", inimigo
    
    return None

def interagir_com_inimigo(inimigo, player, revealed_surface):
    print(f"Você encontrou um inimigo do tipo {inimigo[5]}!")
    resposta = input("Deseja batalhar? (sim/não): ").strip().lower()
    
    if resposta == "sim":
        batalhar(player,inimigo[0], revealed_surface)
    else:
        print("Não passará por aqui sem batalhar!")

def calcular_modificador_tipo(tipo_atacante, tipo_defensor):
    query = """
    SELECT valor FROM interacao WHERE tipo_atacante = %s AND tipo_defensor = %s;
    """
    cursor.execute(query, (tipo_atacante, tipo_defensor))
    resultado = cursor.fetchone()
    return resultado[0] if resultado else 1.0  # 1.0 como padrão (neutro)

def calcular_dano(atacante, defensor, habilidade, tipo_modificador):
    ataque = atacante['ataque_fisico'] if habilidade['tipo_elemental'] in ['fighting', 'normal'] else atacante['ataque_especial']
    defesa = defensor['defesa_fisica'] if habilidade['tipo_elemental'] in ['fighting', 'normal'] else defensor['defesa_fisica']
    dano = ((ataque / defesa) * habilidade['dano'] * tipo_modificador)
    return max(0, int(dano))  # Evita dano negativo

def atacar(atacante, defensor, habilidade):
    # Cálculo de precisão e evasão
    if defensor['evasao'] == 0:
        chance_acerto = habilidade['acuracia']
    else:
        chance_acerto = habilidade['acuracia'] * (atacante['acuracia'] / defensor['evasao'])
    if random.uniform(0, 100) <= chance_acerto:
        # Cálculo do modificador de tipo
        tipo_modificador = calcular_modificador_tipo(habilidade['tipo_elemental'], defensor['tipo_elemental'])
        # Cálculo do dano
        dano = calcular_dano(atacante, defensor, habilidade, tipo_modificador)
        defensor['vida'] -= dano
        print(f"{atacante['nome']} usou {habilidade['nome']}! Causou {dano} de dano.")
        print("\n")
    else:
        print(f"{atacante['nome']} tentou usar {habilidade['nome']}, mas errou!")
        print("\n")

def batalhar(player, inimigo, revealed_surface):
    print("Iniciando batalha...")
    
    # Consultar habilidades do jogador
    query = """
    SELECT h.id_habilidade, h.nome, h.dano, h.acuracia, h.tipo_elemental
    FROM habilidade h
    JOIN pokemon_habilidade ph ON h.id_habilidade = ph.id_habilidade
    WHERE ph.id_pokemon = %s;
    """
    cursor.execute(query, (player,))
    habilidades_jogador = cursor.fetchall()
    habilidades_jogador = [
        {
            'id_habilidade': habilidade[0],
            'nome': habilidade[1],
            'dano': habilidade[2],
            'acuracia': habilidade[3],
            'tipo_elemental': habilidade[4]
        }
        for habilidade in habilidades_jogador
    ]
    player_T = fetch_player_data(player)
    inimigo_T = fetch_enemy_data(inimigo)
    
    # Consultar habilidades do inimigo
    cursor.execute(query, (inimigo,))
    habilidades_inimigo = cursor.fetchall()
    habilidades_inimigo = [
        {
            'id_habilidade': habilidade[0],
            'nome': habilidade[1],
            'dano': habilidade[2],
            'acuracia': habilidade[3],
            'tipo_elemental': habilidade[4]
        }
        for habilidade in habilidades_inimigo
    ]

    while player_T['vida'] > 0 and inimigo_T['vida'] > 0:
        print(f"\nStatus atual:")
        print(f"{player_T['nome']} (Jogador) - Vida: {player_T['vida']}")
        print(f"{inimigo_T['nome']} (Inimigo) - Vida: {inimigo_T['vida']}")
        # Determina quem ataca primeiro com base na velocidade
        if player_T['velocidade'] > inimigo_T['velocidade']:
            # Turno do jogador
            print("\nHabilidades disponíveis:")
            for i, habilidade in enumerate(habilidades_jogador):
                print(f"{i + 1}. {habilidade['nome']} - Dano: {habilidade['dano']} - Acurácia: {habilidade['acuracia']} - Tipo: {habilidade['tipo_elemental']}")
            print("\n")

            escolha = int(input("Escolha uma habilidade para usar: ")) - 1
            habilidade_jogador = habilidades_jogador[escolha]

            atacar(player_T, inimigo_T, habilidade_jogador)
            if inimigo_T['vida'] <= 0:
                print(f"O {inimigo_T['nome']} foi derrotado!")
                cursor.execute("UPDATE jogador SET vida = %s WHERE id_jogador = %s", (player_T['vida'], player))
                cursor.execute("DELETE FROM inimigo WHERE id_inimigo = %s", (inimigo,))
                cursor.execute("UPDATE jogador SET saldo = saldo + 1000 WHERE id_jogador = %s", (player,))
                if inimigo_T['nome'] == 'BOSS':
                    cursor.execute("DELETE FROM inimigo WHERE id_inimigo = %s", (inimigo,))
                    cursor.execute("UPDATE jogador SET saldo = saldo + 1000 WHERE id_jogador = %s", (player,))
                    cursor.execute("UPDATE jogador SET posicao = 6 where id_jogador = %s", (player,))
                    cursor.execute("UPDATE jogador SET vida = 0 where id_jogador = %s", (player,))
                    cursor.execute("UPDATE instancia_missao SET concluida = 'true' where id_jogador =  %s", (player,))
                    print("Você derrotou o BOSS e voltou para a Cidade vitorioso!")
                    conn.commit()
                    break
                conn.commit()
                break

            # Turno do inimigo (escolha randômica)
            habilidade_inimigo = random.choice(habilidades_inimigo)
            atacar(inimigo_T, player_T, habilidade_inimigo)
            if player_T['vida'] <= 0:
                print(f"Você foi derrotado pelo {inimigo_T['nome']}!")
                cursor.execute("UPDATE jogador SET vida = 0 WHERE id_jogador = %s", (player,))
                conn.commit()
        else:
            # Turno do inimigo primeiro
            habilidade_inimigo = random.choice(habilidades_inimigo)
            atacar(inimigo_T, player_T, habilidade_inimigo)
            if player_T['vida'] <= 0:
                print(f"Você foi derrotado pelo {inimigo_T['nome']}!")
                cursor.execute("UPDATE jogador SET vida = 0 WHERE id_jogador = %s", (player,))
                conn.commit()
                break
            
            # Turno do jogador
            print("\nHabilidades disponíveis:")
            for i, habilidade in enumerate(habilidades_jogador):
                print(f"{i + 1}. {habilidade['nome']} - Dano: {habilidade['dano']} - Acurácia: {habilidade['acuracia']} - Tipo: {habilidade['tipo_elemental']}")
                print("\n")

            escolha = int(input("Escolha uma habilidade para usar: ")) - 1
            habilidade_jogador = habilidades_jogador[escolha]
            atacar(player_T, inimigo_T, habilidade_jogador)
            if inimigo_T['vida'] <= 0:
                print(f"O {inimigo_T['nome']} foi derrotado!")
                cursor.execute("UPDATE jogador SET vida = %s WHERE id_jogador = %s", (player_T['vida'], player))
                cursor.execute("DELETE FROM inimigo WHERE id_inimigo = %s", (inimigo,))
                cursor.execute("UPDATE jogador SET saldo = saldo + 1000 WHERE id_jogador = %s", (player,))
                if inimigo_T['nome'] == 'BOSS':
                    cursor.execute("DELETE FROM inimigo WHERE id_inimigo = %s", (inimigo,))
                    cursor.execute("UPDATE jogador SET saldo = saldo + 1000 WHERE id_jogador = %s", (player,))
                    cursor.execute("UPDATE jogador SET posicao = 6 where id_jogador = %s", (player,))
                    cursor.execute("UPDATE jogador SET vida = 0 where id_jogador = %s", (player,))
                    cursor.execute("UPDATE instancia_missao SET concluida = 'true' where id_jogador =  %s", (player,))
                    print("Você derrotou o BOSS e voltou para a Cidade vitorioso!")
                    conn.commit()
                    break
                conn.commit()
                break


def abrir_loja(id_vendedor):
    conn = connect_db()
    cursor = conn.cursor()
    
    # Executar a consulta para obter itens do vendedor
    query = """
    SELECT
        v.id_vendedor,
        v.nome AS vendedor_nome,
        i1.nome AS item_1_nome,
        i1.valor AS item_1_valor,
        i2.nome AS item_2_nome,
        i2.valor AS item_2_valor,
        i3.nome AS item_3_nome,
        i3.valor AS item_3_valor,
        v.item_1 as id_item_1,
        v.item_2 as id_item_2,
        v.item_3 as id_item_3
    FROM
        vendedor v
    LEFT JOIN
        item i1 ON v.item_1 = i1.id_item
    LEFT JOIN
        item i2 ON v.item_2 = i2.id_item
    LEFT JOIN
        item i3 ON v.item_3 = i3.id_item
    WHERE
        v.id_vendedor = %s;
    """
    cursor.execute(query, (id_vendedor,))
    itens = cursor.fetchone()
    
    # Fechar a conexão com o banco de dados
    cursor.close()
    conn.close()
    
    if itens:
        print(f"Itens disponíveis com o vendedor {itens[1]}:")
        print(f"1. {itens[2]} - {itens[3]} moedas")
        print(f"2. {itens[4]} - {itens[5]} moedas")
        print(f"3. {itens[6]} - {itens[7]} moedas")

        escolha = int(input("Digite o número do item que deseja comprar: "))

        if escolha == 1:
            id_item = itens[8]
            valor_item = itens[3]
        elif escolha == 2:
            id_item = itens[9]
            valor_item = itens[5]
        elif escolha == 3:
            id_item = itens[10]
            valor_item = itens[7]
        else:
            print("Escolha inválida.")
            return

        # Comprar o item
        comprar_item(player, id_item, valor_item)
    else:
        print("Não há itens disponíveis com este vendedor.")

def interagir_com_vendedor(vendedor):
    cursor.execute("SELECT fala FROM dialogo WHERE personagem = 'Vendedor' ORDER BY ordem")
    dialogos = cursor.fetchall()
    for dialogo in dialogos:
        print(dialogo[0])
        input("Pressione Enter para continuar...")
    resposta = input("Deseja comprar algo? (sim/não): ").strip().lower()
    
    if resposta == "sim":
        abrir_loja(vendedor[0])
    else:
        print("Ok, tenha um bom dia!")

def comprar_item(id_jogador, id_item, valor_item):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("SELECT saldo FROM jogador WHERE id_jogador = %s;", (id_jogador,))
    saldo = cursor.fetchone()[0]

    if saldo >= valor_item:
        cursor.execute("INSERT INTO instancia_item (id_item) VALUES (%s) RETURNING id_instancia_item;", (id_item,))
        id_instancia_item = cursor.fetchone()[0]

        cursor.execute("""
            INSERT INTO inventario (id_inventario, id_instancia_item) 
            VALUES (%s, %s);
        """, (id_jogador, id_instancia_item))

        cursor.execute("""
            UPDATE jogador
            SET saldo = saldo - %s
            WHERE id_jogador = %s;
        """, (valor_item, id_jogador))

        conn.commit()
        print("Compra realizada com sucesso!")
    else:
        print("Saldo insuficiente para comprar este item.")

    cursor.close()
    conn.close()

# Função para verificar se o jogador está sobre a escada
def check_on_ladder(player_x, player_y, terrains):
    player_rect = pygame.Rect(player_x, player_y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        if descricao == 'Escada':
            ladder_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
            if player_rect.colliderect(ladder_rect):
                return True
    return False

def check_on_portal(player_x, player_y, terrains):
    player_rect = pygame.Rect(player_x, player_y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        if descricao == 'Portal':
            ladder_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
            if player_rect.colliderect(ladder_rect):
                return True
    return False

def draw_tree(surface, x, y):
    # Desenha o tronco da árvore
    pygame.draw.rect(surface, BROWN, (x * square_size + square_size // 4, y * square_size + square_size // 2, square_size // 2, square_size // 2))
    pygame.draw.circle(surface, DARK_GREEN, (x * square_size + square_size // 2, y * square_size + square_size // 4), square_size // 2)

def draw_brick(surface, x, y):
    # Desenha o corpo do tijolo
    pygame.draw.rect(surface, BLACK, (x * square_size, y * square_size, square_size, square_size))
    
    # Desenha as divisórias do tijolo
    pygame.draw.line(surface, DARK_GREY, (x * square_size, y * square_size + square_size // 2), (x * square_size + square_size, y * square_size + square_size // 2), 2)
    pygame.draw.line(surface, DARK_GREY, (x * square_size + square_size // 3, y * square_size), (x * square_size + square_size // 3, y * square_size + square_size), 2)
    pygame.draw.line(surface, DARK_GREY, (x * square_size + 2 * square_size // 3, y * square_size), (x * square_size + 2 * square_size // 3, y * square_size + square_size), 2)


def draw_grass(surface, x, y):
    # Desenha a base da grama como um verde claro
    pygame.draw.rect(surface, LIGHT_GREEN, (x * square_size, y * square_size, square_size, square_size))
    
    # Adiciona alguns detalhes de grama com verde escuro para simular textura
    for _ in range(5):  # Ajuste o número de detalhes
        blade_x = x * square_size + random.randint(0, square_size - 1)
        blade_y = y * square_size + random.randint(0, square_size - 1)
        blade_width = random.randint(2, 5)  # Largura de cada detalhe de grama
        blade_height = random.randint(2, 5)  # Altura de cada detalhe de grama
        
        pygame.draw.ellipse(surface, DARK_GREEN, (blade_x, blade_y, blade_width, blade_height))

def draw_ground(surface, x, y):
    # Desenha a base do chão com uma cor marrom clara
    pygame.draw.rect(surface, BROWN, (x * square_size, y * square_size, square_size, square_size))
    
    # Adiciona alguns detalhes em marrom escuro para simular irregularidades no chão
    for _ in range(5):  # Ajuste o número de detalhes
        patch_x = x * square_size + random.randint(0, square_size - 1)
        patch_y = y * square_size + random.randint(0, square_size - 1)
        patch_width = random.randint(2, 5)  # Largura de cada detalhe no chão
        patch_height = random.randint(2, 5)  # Altura de cada detalhe no chão
        
        pygame.draw.ellipse(surface, DARK_GREY, (patch_x, patch_y, patch_width, patch_height))


def draw_ground_mission(surface, x, y):
    # Desenha a base do chão com uma cor marrom clara
    pygame.draw.rect(surface, PURPLE_D, (x * square_size, y * square_size, square_size, square_size))
    
    # Adiciona alguns detalhes em marrom escuro para simular irregularidades no chão
    for _ in range(5):  # Ajuste o número de detalhes
        patch_x = x * square_size + random.randint(0, square_size - 1)
        patch_y = y * square_size + random.randint(0, square_size - 1)
        patch_width = random.randint(2, 5)  # Largura de cada detalhe no chão
        patch_height = random.randint(2, 5)  # Altura de cada detalhe no chão
        
        pygame.draw.ellipse(surface, PURPLE, (patch_x, patch_y, patch_width, patch_height))

def draw_stairs_with_shadow(surface, x, y):
    # Desenha a base da escada com um retângulo cinza claro
    pygame.draw.rect(surface, GREY, (x * square_size, y * square_size, square_size, square_size))
    
    # Adiciona degraus horizontais
    num_steps = 4  # Número de degraus
    step_height = square_size // num_steps  # Altura de cada degrau
    
    for i in range(1, num_steps):
        step_y = y * square_size + i * step_height
        pygame.draw.line(surface, DARK_GREY, (x * square_size, step_y), (x * square_size + square_size, step_y), 2)
    
    # Adiciona sombreamento na parte inferior e direita dos degraus para dar profundidade
    shadow_width = 5  # Largura da sombra
    for i in range(num_steps):
        # Desenha sombra na parte direita de cada degrau
        step_y = y * square_size + i * step_height
        pygame.draw.rect(surface, DARK_GREY, (x * square_size + square_size - shadow_width, step_y, shadow_width, step_height))
        
        # Desenha sombra na parte inferior de cada degrau
        pygame.draw.rect(surface, DARK_GREY, (x * square_size, step_y + step_height - shadow_width, square_size, shadow_width))


def draw_mailbox(surface, x, y):
    # Definição das cores
    YELLOW = (255, 255, 0)
    ORANGE = (255, 165, 0)
    WHITE = (255, 255, 255)
    DARK_GREY = (105, 105, 105)
    
    # Desenha a base da caixa de correio em amarelo
    pygame.draw.rect(surface, YELLOW, (x * square_size, y * square_size, square_size, square_size // 2))
    
    # Desenha o topo da caixa de correio (a tampa) em amarelo mais escuro
    pygame.draw.rect(surface, ORANGE, (x * square_size, y * square_size - square_size // 6, square_size, square_size // 6))
    
    # Desenha a abertura da caixa de correio em branco
    pygame.draw.rect(surface, WHITE, (x * square_size + square_size // 4, y * square_size + square_size // 4, square_size // 2, square_size // 8))
    
    # Desenha o suporte da caixa de correio em cinza escuro
    pygame.draw.rect(surface, DARK_GREY, (x * square_size + square_size // 4 - 3, y * square_size + square_size // 2, 3, square_size // 2))
    
    # Configura a fonte para o texto
    font = pygame.font.Font(None, 24)  # Fonte padrão, tamanho 24
    text_surface = font.render('MAIL', True, DARK_GREY)  # Texto em cinza escuro
    text_rect = text_surface.get_rect(center=(x * square_size + square_size // 2, y * square_size + square_size // 4))
    
    # Desenha o texto na caixa de correio
    surface.blit(text_surface, text_rect)


def draw_black_hole(surface, x, y):
    # Centro do buraco negro
    center_x = x * square_size + square_size // 2
    center_y = y * square_size + square_size // 2
    max_radius = square_size // 2  # Raio máximo do buraco negro

    # Camadas de sombreamento para dar a impressão de profundidade
    for i in range(10):  # Número de camadas
        # Cor varia do preto ao cinza
        shade = 255 - (i * 25)
        color = (shade, shade, shade)
        
        # Raio para cada camada diminui gradualmente
        radius = max_radius - (i * (max_radius // 10))
        
        # Desenha a camada circular
        pygame.draw.circle(surface, color, (center_x, center_y), radius)

    # Desenha o núcleo totalmente preto no centro
    pygame.draw.circle(surface, BLACK, (center_x, center_y), max_radius // 4)


# Função para desenhar os terrenos
def draw_terrains(surface, terrains):
    for (_, x, y, descricao) in terrains:
        if descricao == 'Parede':
            draw_brick(surface, x, y)  # Usa a função para desenhar o tijolo
            continue
        elif descricao == 'Água':
            color = BLUE
        elif descricao == 'Chão':
            draw_ground(surface, x, y)
            continue
        elif descricao == 'Escada':
            draw_stairs_with_shadow(surface, x, y)
            continue  # Usa a função para desenhar a escada
        elif descricao == 'Árvore':
            draw_tree(surface, x, y)  # Usa a função para desenhar a árvore
            continue
        elif descricao == 'Grama':
            draw_grass(surface, x, y)
            continue
        elif descricao == 'Correio':
            draw_mailbox(surface, x, y)
            continue
        elif descricao == 'Veneno':
            draw_ground_mission(surface, x, y)
            continue
        elif descricao == 'Portal':
            draw_black_hole(surface, x, y)
            continue
        else:
            color = WHITE  # Cor padrão se a descrição não for reconhecida
        pygame.draw.rect(surface, color, (x * square_size, y * square_size, square_size, square_size))

# Função para mudar de andar
def change_floor(current_floor, mapa, terrains, revealed_surface):
    next_floor = current_floor + 1
    cursor.execute("SELECT id_andar FROM andar where numero_andar = %s AND nome_mapa = %s", (next_floor, mapa))
    andar = cursor.fetchone()[0]
    if next_floor != current_floor:
        current_floor = next_floor
        cursor.execute("SELECT id_terreno FROM terreno WHERE id_andar = %s and x = 0 and y = 0", (andar,))
        posicao = cursor.fetchone()
        nova_posicao = posicao[0]
        cursor.execute("UPDATE jogador SET posicao = %s WHERE id_jogador = %s", (nova_posicao, player))
        conn.commit()
        terrains = fetch_terrains(player)
        revealed_surface.fill(BLACK)
        draw_terrains(revealed_surface, terrains)
        print(f"Subiu para o andar {current_floor}")
    return current_floor, terrains, andar

def teletransporta_missao(id_jogador, terrains, revealed_surface):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("""SELECT 
                        im.id_missao,
                        m.nome_mapa,
                        m.objetivo
                   FROM instancia_missao im 
                   JOIN missao m on im.id_missao = m.id_missao
                   WHERE id_jogador = %s and concluida = 'false'""", (id_jogador,))
    missao_id = cursor.fetchone()
    if not missao_id:
        print("Você não tem missão ativa.")
        current_floor = 1
        andar = 6
        mapa = 'Cidade'
        terrains = fetch_terrains(player)
        return current_floor, terrains, andar, mapa
    missao_ativa = missao_id[1]
    print(f"Missão ativa: {missao_id[2]} na {missao_id[1]}")
    mapa = missao_ativa
    
    resposta = input("Deseja fazer a missão? (sim/não): ").strip().lower()
    if resposta == 'sim':
        cursor.execute("""
                    select 
                    t.id_terreno
                    from mapa m
                    join andar a on a.nome_mapa = m.nome
                    join terreno t on a.id_andar = t.id_andar
                    where t.x = 0 and t.y = 0 and m.nome = %s and a.numero_andar = 1
                    """, (missao_ativa,))
        terreno_id = cursor.fetchone()[0]
        cursor.execute("""
                    select 
                    a.id_andar
                    from mapa m
                    join andar a on a.nome_mapa = m.nome
                    join terreno t on a.id_andar = t.id_andar
                    where t.x = 0 and t.y = 0 and m.nome = %s and a.numero_andar = 1
                    """, (missao_ativa,))
        andar = cursor.fetchone()[0]
        cursor.execute("UPDATE jogador SET posicao = %s WHERE id_jogador = %s", (terreno_id, id_jogador))
        conn.commit()
        terrains = fetch_terrains(player)
        revealed_surface.fill(BLACK)
        current_floor = 1
        draw_terrains(revealed_surface, terrains)
        print("Teletransporte efetuado com sucesso!")
        return current_floor, terrains, andar, mapa
    else:
        print("Até mais !.")
        current_floor = 1
        andar = 6
        mapa = 'Cidade'
        terrains = fetch_terrains(player)
        return current_floor, terrains, andar, mapa

def clamp_position(x, y):
    # Corrige a posição (x, y) para garantir que esteja dentro dos limites do mapa.
    x = max(0, min(x, movement_limit_width - square_size))
    y = max(0, min(y, movement_limit_height - square_size))
    return x, y

def abre_inventario(player):
    conn = connect_db()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT item.nome, item.descricao, item.efeito, COUNT(ii.id_instancia_item) AS quantidade
        FROM inventario i
                JOIN jogador j ON i.id_inventario = j.id_jogador
                JOIN instancia_item ii ON i.id_instancia_item = ii.id_instancia_item
                JOIN item ON item.id_item = ii.id_item
        WHERE j.id_jogador = %s
        GROUP BY item.nome, item.descricao, item.efeito;
    """, (player,))
    itens = cursor.fetchall()

    if itens:
        headers = ["Nome", "Descrição", "Efeito", "Quantidade"]
        print("Itens no inventário:")
        print(tabulate(itens, headers, tablefmt="grid"))

        consome_item(player, itens)  # Chama a função para consumir o item após listar o inventário
    else:
        print("Inventário vazio.")

    cursor.close()
    conn.close()

def consome_item(player, itens):
    escolha = input("Digite o nome do item que quer consumir: ").strip()

    item_encontrado = next((item for item in itens if item[0].lower() == escolha.lower()), None)

    if item_encontrado:
        nome_item = item_encontrado[0]

        conn = connect_db()
        cursor = conn.cursor()
        
        if nome_item == "Poção":
            cursor.execute("UPDATE jogador SET vida = LEAST(vida + 50, nivel * 100) WHERE id_jogador = %s", (player,))
            print("Você recuperou 50 de vida!")
        elif nome_item == "Elixir":
            print("Efeito de Elixir: Recupera todos os PP!")
        elif nome_item == "Reviver":
            cursor.execute("UPDATE jogador SET vida = GREATEST((nivel * 100) / 2, 1) WHERE id_jogador = %s AND vida = 0", (player,))
            print("Seu Pokémon foi revivido com metade da vida!")

        # Remova o item consumido
        cursor.execute("""
            DELETE FROM inventario
            WHERE id_instancia_item = (
                SELECT ii.id_instancia_item
                FROM instancia_item ii
                JOIN item i ON ii.id_item = i.id_item
                WHERE i.nome = %s
                AND ii.id_instancia_item IN (
                    SELECT id_instancia_item
                    FROM inventario
                    WHERE id_inventario = %s
                )
                ORDER BY ii.id_instancia_item
                LIMIT 1
            )
        """, (nome_item, player))
        conn.commit()

        cursor.close()
        conn.close()

    else:
        print("Item não encontrado no inventário.")

def retorna_posicao(player):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT vida from jogador where id_jogador = %s", (player,))
    vida = cursor.fetchone()[0]
    if vida == 0:
        return True
    else:
        return False

def teleporta_cidade(player):
    cursor.execute("UPDATE jogador SET posicao = 6 where id_jogador = %s", (player,))
    cursor.execute("UPDATE jogador SET vida = 1000 where id_jogador = %s", (player,))
    conn.commit()
    current_floor = 1
    andar = 6
    mapa = 'Cidade'
    terrains = fetch_terrains(player)
    return current_floor, terrains, andar, mapa

def write_text(surface, text, x, y):
    # Configura a fonte para o texto
    font = pygame.font.Font(None, 24)  # Fonte padrão, tamanho 24
    text_surface = font.render(text, True, WHITE)
    text_rect = text_surface.get_rect(topleft=(x, y))
    
    # Desenha o texto na tela
    surface.blit(text_surface, text_rect)
    
# Funcao para achar a missao do player
def find_mission_player(player_id):
    query = """
    SELECT m.objetivo
    FROM instancia_missao im
    JOIN missao m ON im.id_missao = m.id_missao
    WHERE im.id_jogador = %s AND im.concluida = 'false';
    """
    try:
        cursor.execute(query, (player_id,))
        missao = cursor.fetchone()
        if missao:
            return missao[0]
        return None
    except Exception as e:
        print("Erro ao buscar missão do jogador:", e)
        return None
    


def main():
    global andar, mapa, player, tipo, player_x, player_y, inimigos
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
            posicao = find_xy_terreno(player)
            player_x = posicao[0] * 50
            player_y = posicao[1] * 50
            tipo = tipo_elemental_pokemon(player)
        else:
            select_existing_player()
            player = int(input("Qual jogo deseja continuar ? "))
            andar_mapa = fetch_andar_map(player)
            andar = andar_mapa[0]
            mapa = andar_mapa[1]
            posicao = find_xy_terreno(player)
            player_x = posicao[0] * 50
            player_y = posicao[1] * 50
            tipo = tipo_elemental_pokemon(player)

    else:
        get_narrator_dialogue()
        list_pokemon()
        pokemon_id = int(input("Digite o número do Pokémon que deseja ser: "))
        player = create_player(pokemon_id)
        andar = 6
        mapa = 'Cidade'
        posicao = find_xy_terreno(player)
        player_x = posicao[0] * 50
        player_y = posicao[1] * 50
        tipo = tipo_elemental_pokemon(player)

    # Inicialize o pygame
    window = initialize_pygame()

    # Variáveis do jogo
    current_floor = get_floor(player)
    terrains = fetch_terrains(player)
    vendedores = fetch_vendedores()
    # Criar uma superfície para o mapa revelado
    revealed_surface = pygame.Surface((movement_limit_width, movement_limit_height))
    revealed_surface.fill(BLACK)

    # Criar a superfície da fog
    fog_surface = initialize_fog_surface()

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
                new_x, new_y = player_x, player_y  # Inicializa com a posição atual
                
                if event.key == pygame.K_i:
                    abre_inventario(player)
                    print("Abrindo inventário...")

                if event.key == pygame.K_LEFT:
                    new_x = player_x - square_size
                elif event.key == pygame.K_RIGHT:
                    new_x = player_x + square_size
                elif event.key == pygame.K_UP:
                    new_y = player_y - square_size
                elif event.key == pygame.K_DOWN:
                    new_y = player_y + square_size
                
                # Corrigir a posição se necessário
                new_x, new_y = clamp_position(new_x, new_y)

                # Verificar colisão com terrenos e vendedores
                if mapa == 'Cidade':
                    if not check_collision(new_x, new_y, terrains, player) and not check_collision_vendedor(new_x, new_y, vendedores):
                        player_x, player_y = new_x, new_y
                else:
                    if not check_collision(new_x, new_y, terrains, player) and not check_collision_inimigo(new_x, new_y, inimigos, player, revealed_surface):
                        player_x, player_y = new_x, new_y
                    
                new_terreno = find_id_terreno(player_x, player_y, andar)
                cursor.execute("UPDATE jogador SET posicao = %s WHERE id_jogador = %s", (new_terreno, player))
                conn.commit()

        # Verifique se o jogador está sobre a escada
        if check_on_ladder(player_x, player_y, terrains):
            current_floor, terrains, andar = change_floor(current_floor, mapa, terrains, revealed_surface)
            fog_surface = initialize_fog_surface() 
            player_x, player_y = 0, 0
        
        if check_on_portal(player_x, player_y, terrains):
            current_floor, terrains, andar, mapa = teletransporta_missao(player, terrains, revealed_surface)
            fog_surface = initialize_fog_surface()
            player_x, player_y = 0, 0

        # Limitar o movimento do jogador à área definida
        player_x, player_y = clamp_position(player_x, player_y)

        # Calcular o deslocamento da "câmera"
        offset_x = max(0, min(player_x - window_width // 2, movement_limit_width - window_width))
        offset_y = max(0, min(player_y - window_height // 2, movement_limit_height - window_height))

        # Preencher a janela
        window.fill(BLACK)

        # Desenhar a superfície de áreas reveladas com deslocamento
        window.blit(revealed_surface, (-offset_x, -offset_y))

        # Desenhar o jogador
        draw_player(window, offset_x, offset_y, player_x, player_y, tipo)
        
        if mapa == 'Cidade':
            draw_vendedores(window, offset_x, offset_y, vendedores)
        else:
            inimigos = fetch_inimigos(mapa,andar)
            draw_inimigos(window, offset_x, offset_y, inimigos)
            reveal_area(fog_surface, player_x, player_y, radius=100)
            window.blit(fog_surface, (-offset_x, -offset_y))
            if retorna_posicao(player):
                current_floor, terrains, andar, mapa = teleporta_cidade(player)
                draw_terrains(revealed_surface, terrains)
                fog_surface = initialize_fog_surface()
                player_x, player_y = 0, 0

            
        # Desenhar o indicativo de localizacao
        write_text(window, f"Mapa: {mapa} - Andar: {current_floor}", 10, 10)
        
        # Desenhar o indicativo de missao
        missao = find_mission_player(player)
        if missao != None:
            write_text(window, f"Missao: {missao}", 10, 30)

        pygame.display.flip()

    pygame.quit()
    sys.exit()

# Função para inicializar a superfície de fog
def initialize_fog_surface():
    # Criar uma superfície para a fog (tamanho do mapa)
    fog_surface = pygame.Surface((movement_limit_width, movement_limit_height), pygame.SRCALPHA)
    fog_surface.fill((0, 0, 0)) 
    return fog_surface

# Função para revelar área ao redor do jogador
def reveal_area(fog_surface, player_x, player_y, radius):
    pygame.draw.circle(fog_surface, (0, 0, 0, 0), (player_x, player_y), radius)

if __name__ == '__main__':
    main()
