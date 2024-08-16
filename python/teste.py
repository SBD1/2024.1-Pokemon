import pygame
import sys
import psycopg2

# Configurações do banco de dados
DB_HOST = '172.22.0.1'
DB_NAME = 'pokemon'
DB_USER = 'empreender_local'
DB_PASSWORD = '123456'


# Função para conectar ao banco de dados
def connect_db():
    return psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)


# Função para obter terrenos com base no andar atual
def fetch_terrains(map, current_floor):
    conn = connect_db()
    cursor = conn.cursor()  # OBS1. Tem que fazer join com o mapa também a ordem seria mapa -> andar -> terreno
    cursor.execute("""
    SELECT t.id_terreno , t.x, t.y, tt.descricao
    FROM terreno t
    JOIN tipo_terreno tt ON t.id_tipo_terreno = tt.id_tipo_terreno
    JOIN andar a ON t.id_andar = a.id_andar AND a.nome_mapa = %s
    WHERE a.num_andar = %s
""", (map, current_floor))  # OBS2. Tem que guardar na tabela de andar qual o spawn point do jogador (pode colocar um FK para o id_terreno)
    terrains = cursor.fetchall()
    cursor.close()
    conn.close()
    return terrains


# Função para obter o próximo andar
def get_next_floor(current_floor):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT MAX(t.id_andar) FROM terreno t
    """)
    max_floor = cursor.fetchone()[0]
    cursor.close()
    conn.close()
    return min(current_floor + 1, max_floor)  # Não exceder o andar máximo


# Função para inicializar o pygame
def initialize_pygame():
    pygame.init()
    return pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)


# Função para desenhar o jogador
def draw_player(surface, offset_x, offset_y):
    pygame.draw.rect(surface, RED, (player_x - offset_x, player_y - offset_y, square_size, square_size))


# Função para verificar colisão com obstáculos
def check_collision(x, y):
    player_rect = pygame.Rect(x, y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        terrain_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
        if player_rect.colliderect(terrain_rect):
            if descricao in ['Parede', 'Água']:
                return True
    return False


# Função para verificar se o jogador está sobre a escada
def check_on_ladder():
    player_rect = pygame.Rect(player_x, player_y, square_size, square_size)
    for (_, tx, ty, descricao) in terrains:
        if descricao == 'Escada':
            ladder_rect = pygame.Rect(tx * square_size, ty * square_size, square_size, square_size)
            if player_rect.colliderect(ladder_rect):
                return True
    return False


# Função para desenhar os terrenos
def draw_terrains(surface):
    for (_, x, y, descricao) in terrains:
        if descricao == 'Parede':
            color = BLACK
        elif descricao == 'Água':
            color = BLUE
        elif descricao == 'Chão':
            color = BROWN
        elif descricao == 'Escada':
            color = GREY
        else:
            color = WHITE  # Cor padrão se a descrição não for reconhecida

        rect_x = x * square_size
        rect_y = y * square_size
        pygame.draw.rect(surface, color, (rect_x, rect_y, square_size, square_size))


# Definir as cores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
BROWN = (139, 69, 19)
GREY = (128, 128, 128)

# Configurações do mapa
square_size = 50
map_size = 50  # O mapa é 50x50 quadrados

# Dimensões da superfície do mapa
movement_limit_width = map_size * square_size
movement_limit_height = map_size * square_size

# Dimensões da janela
window_width, window_height = 800, 600

# Variável para armazenar o andar atual
current_floor = 1

# Inicialize o pygame
window = initialize_pygame()

# Obter os terrenos do andar atual
terrains = fetch_terrains('Teste',current_floor)

# Criar uma superfície para o mapa
revealed_surface = pygame.Surface((movement_limit_width, movement_limit_height))

# Inicialmente, preenche com branco
revealed_surface.fill(WHITE)

# Desenhe todos os terrenos na superfície revelada
draw_terrains(revealed_surface)

# Coordenadas iniciais do jogador
player_x, player_y = (movement_limit_width // 4) // square_size * square_size, (movement_limit_height // 2) // square_size * square_size


# Função para mudar de andar
def change_floor():
    global current_floor, terrains
    next_floor = get_next_floor(current_floor)
    if next_floor != current_floor:
        current_floor = next_floor
        terrains = fetch_terrains('Teste', current_floor)
        revealed_surface.fill(WHITE)
        draw_terrains(revealed_surface)
        print(f"Subiu para o andar {current_floor}")


# Loop principal do jogo
running = True
while running:
    # Captura de eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.VIDEORESIZE:
            window_width, window_height = event.w, event.h
            window = initialize_pygame()
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                new_x = player_x - square_size
                if not check_collision(new_x, player_y):
                    player_x = new_x
            elif event.key == pygame.K_RIGHT:
                new_x = player_x + square_size
                if not check_collision(new_x, player_y):
                    player_x = new_x
            elif event.key == pygame.K_UP:
                new_y = player_y - square_size
                if not check_collision(player_x, new_y):
                    player_y = new_y
            elif event.key == pygame.K_DOWN:
                new_y = player_y + square_size
                if not check_collision(player_x, new_y):
                    player_y = new_y

    # Verifique se o jogador está sobre a escada
    if check_on_ladder():
        change_floor()
        player_x = (movement_limit_width // 4) // square_size * square_size
        player_y = (movement_limit_height // 2) // square_size * square_size

    # Limitar o movimento do jogador à área definida
    player_x = max(0, min(player_x, movement_limit_width - square_size))
    player_y = max(0, min(player_y, movement_limit_height - square_size))

    # Calcular o deslocamento da "câmera" para manter o jogador no centro da tela
    offset_x = max(0, min(player_x - window_width // 2, movement_limit_width - window_width))
    offset_y = max(0, min(player_y - window_height // 2, movement_limit_height - window_height))

    # Preencher a janela
    window.fill(WHITE)

    # Desenhar a superfície de áreas reveladas com deslocamento
    window.blit(revealed_surface, (-offset_x, -offset_y))

    # Desenhar o jogador
    draw_player(window, offset_x, offset_y)

    pygame.display.flip()

pygame.quit()
sys.exit()
