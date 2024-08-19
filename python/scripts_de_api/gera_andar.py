import random

# IDs dos tipos de terreno
id_chao = 1    # Chão
id_agua = 2    # Água
id_parede = 3  # Parede
id_arvore = 4  # Árvore
id_escada = 5  # Escada
id_grama = 6   # Grama

# ID do andar recém-criado
id_andar = 6   # Ajuste conforme necessário

# Função para gerar a cidadezinha
def generate_city_map(id_andar, size=50):
    sql_commands = []
    
    # Inicializa o mapa com chão
    for x in range(size):
        for y in range(size):
            sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_chao}, {id_andar});")
    
    # Adiciona ruas (caminho de chão)
    for y in range(10, 40, 5):
        for x in range(size):
            sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_chao}, {id_andar});")
    
    # Adiciona calçadas (grama e árvores ao redor das ruas)
    for x in range(size):
        for y in [9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39]:
            if (x % 5 == 0):
                sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_grama}, {id_andar});")
                if random.random() < 0.1:
                    sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_arvore}, {id_andar});")
    
    # Adiciona casinhas (com três paredes e uma entrada)
    house_size = 4
    houses = [(5, 5), (15, 15), (25, 25), (35, 35)]  # Coordenadas das casas
    for (hx, hy) in houses:
        # Paredes laterais e superior
        for x in range(hx, hx + house_size):
            # Parede superior
            sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {hy}, {id_parede}, {id_andar});")
        for y in range(hy, hy + house_size):
            # Parede lateral esquerda
            if x == hx:
                sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({hx}, {y}, {id_parede}, {id_andar});")
            # Parede lateral direita
            if x == hx + house_size - 1:
                sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({hx + house_size - 1}, {y}, {id_parede}, {id_andar});")
                
        # Adiciona a entrada (dois quadrados de largura na frente da casa)
        sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({hx + 1}, {hy - 1}, {id_chao}, {id_andar});")
        sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({hx + 2}, {hy - 1}, {id_chao}, {id_andar});")
        
        # Chão dentro da casa
        for x in range(hx + 1, hx + house_size - 1):
            for y in range(hy + 1, hy + house_size - 1):
                sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_chao}, {id_andar});")
    
    # Adiciona escada no fim do mapa
    sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({size - 1}, {size - 1}, {id_escada}, {id_andar});")
    
    return sql_commands

# Gerar SQL para a cidadezinha
sql_commands = generate_city_map(id_andar)

# Imprimir comandos SQL
for sql in sql_commands:
    print(sql)
