import pygame
import sys

# Inicialize o pygame
pygame.init()

# Defina as dimensões da janela e a área de movimentação
window_width, window_height = 800, 600
movement_limit_width, movement_limit_height = 1600, 1200  # Área de movimentação maior que a tela

# Criar a janela com opção de redimensionamento
window = pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)

# Defina as cores
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
GREEN = (0, 255, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
BROWN = (139, 69, 19)

# Defina as coordenadas iniciais do jogador
player_x, player_y = movement_limit_width // 2, movement_limit_height // 2

# Defina as coordenadas iniciais do NPC e escada
npc_x, npc_y = 700, 500
npc_size = 50

# Defina as coordenadas e tamanho da escada
stairs_x, stairs_y = 400, 300
stairs_size = 50

# Defina o tamanho do quadrado do mapa
square_size = 50

# Defina a fonte para o texto
font = pygame.font.Font(None, 24)

# Criar uma superfície para áreas reveladas
revealed_surface = pygame.Surface((movement_limit_width, movement_limit_height), pygame.SRCALPHA)
revealed_surface.fill((0, 0, 0, 255))  # Preenchendo com preto opaco

# Definir as áreas do mapa (parede, água, escada)
walls = [(100, 100, square_size, square_size), (150, 100, square_size, square_size)]
water = [(200, 200, square_size, square_size), (250, 200, square_size, square_size)]
stairs = (stairs_x, stairs_y, stairs_size, stairs_size)

# Função para desenhar o mapa
def draw_map(surface, offset_x, offset_y):
    for x in range(0, movement_limit_width, square_size):
        for y in range(0, movement_limit_height, square_size):
            pygame.draw.rect(surface, WHITE, (x - offset_x, y - offset_y, square_size, square_size), 1)

# Função para desenhar o jogador
def draw_player(surface, offset_x, offset_y):
    pygame.draw.rect(surface, BLACK, (player_x - offset_x, player_y - offset_y, square_size, square_size))

# Função para desenhar o NPC
def draw_npc(surface, offset_x, offset_y):
    pygame.draw.rect(surface, GREEN, (npc_x - offset_x, npc_y - offset_y, npc_size, npc_size))

# Função para desenhar a escada
def draw_stairs(surface, offset_x, offset_y):
    pygame.draw.rect(surface, RED, (stairs_x - offset_x, stairs_y - offset_y, stairs_size, stairs_size))

# Função para desenhar as paredes
def draw_walls(surface, offset_x, offset_y):
    for wall in walls:
        pygame.draw.rect(surface, BROWN, (wall[0] - offset_x, wall[1] - offset_y, wall[2], wall[3]))

# Função para desenhar a água
def draw_water(surface, offset_x, offset_y):
    for w in water:
        pygame.draw.rect(surface, BLUE, (w[0] - offset_x, w[1] - offset_y, w[2], w[3]))

# Função para exibir texto na tela
def draw_text(text, font, color, surface, x, y):
    text_obj = font.render(text, True, color)
    text_rect = text_obj.get_rect()
    text_rect.topleft = (x, y)
    surface.blit(text_obj, text_rect)

# Função para atualizar a superfície de áreas reveladas
def update_revealed_area():
    visibility_radius = 100
    pygame.draw.circle(revealed_surface, (0, 0, 0, 0), (player_x, player_y), visibility_radius)

# Função para verificar colisão com obstáculos
def check_collision(x, y):
    player_rect = pygame.Rect(x, y, square_size, square_size)
    for wall in walls:
        if player_rect.colliderect(wall):
            return True
    for w in water:
        if player_rect.colliderect(w):
            return True
    return False

# Função para interação com o NPC no terminal
def interact_with_npc():
    print("Olá, seja bem-vindo à minha loja, o que deseja comprar?")
    print("1 - Faca")
    print("2 - Corda")
    
    choice = input("Escolha uma opção: ")
    
    if choice == '1':
        print("Você comprou uma Faca.")
    elif choice == '2':
        print("Você comprou uma Corda.")
    else:
        print("Opção inválida.")
    
    print("Muito obrigado! Até mais!")

# Loop principal do jogo
running = True
while running:
    # Captura de eventos
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.VIDEORESIZE:
            window_width, window_height = event.w, event.h
            window = pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                if not check_collision(player_x - square_size, player_y):
                    player_x -= square_size
            elif event.key == pygame.K_RIGHT:
                if not check_collision(player_x + square_size, player_y):
                    player_x += square_size
            elif event.key == pygame.K_UP:
                if not check_collision(player_x, player_y - square_size):
                    player_y -= square_size
            elif event.key == pygame.K_DOWN:
                if not check_collision(player_x, player_y + square_size):
                    player_y += square_size
            elif event.key == pygame.K_RETURN:
                # Verifica se o jogador está perto do NPC
                if abs(player_x - npc_x) < square_size and abs(player_y - npc_y) < square_size:
                    interact_with_npc()  # Inicia a interação no terminal
    
    # Limitar o movimento do jogador à área definida
    player_x = max(0, min(player_x, movement_limit_width - square_size))
    player_y = max(0, min(player_y, movement_limit_height - square_size))
    
    # Calcular o deslocamento da "câmera" para manter o jogador no centro da tela
    offset_x = max(0, min(player_x - window_width // 2, movement_limit_width - window_width))
    offset_y = max(0, min(player_y - window_height // 2, movement_limit_height - window_height))
    
    # Preencher a janela
    window.fill(WHITE)
    
    # Desenhar o mapa, NPC, escada, paredes, água e jogador com deslocamento
    draw_map(window, offset_x, offset_y)
    draw_walls(window, offset_x, offset_y)
    draw_water(window, offset_x, offset_y)
    draw_stairs(window, offset_x, offset_y)
    draw_npc(window, offset_x, offset_y)
    draw_player(window, offset_x, offset_y)
    
    # Exibir texto acima do NPC quando o jogador está próximo
    if abs(player_x - npc_x) < square_size and abs(player_y - npc_y) < square_size:
        draw_text("Pressione ENTER", font, BLACK, window, npc_x - offset_x, npc_y - offset_y - 20)
    
    # Atualizar a superfície de áreas reveladas
    update_revealed_area()
    
    # Desenhar a superfície de áreas reveladas
    window.blit(revealed_surface.subsurface(offset_x, offset_y, window_width, window_height), (0, 0))

    pygame.display.flip()

pygame.quit()
sys.exit()
