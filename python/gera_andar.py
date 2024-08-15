import random

# IDs dos tipos de terreno
id_parede = 1  # ID do tipo 'Parede'
id_agua = 2    # ID do tipo 'Água'
id_chao = 3    # ID do tipo 'Chão'

# ID do andar recém-criado
id_andar = 3   # Ajuste conforme necessário

# Função para gerar comando SQL para terrenos
def generate_random_terrain_inserts(id_andar, start_x=0, start_y=0, end_x=49, end_y=49):
    sql_commands = []
    for x in range(start_x, end_x + 1):
        for y in range(start_y, end_y + 1):
            # Escolhe aleatoriamente o tipo de terreno
            tipo_terreno = random.choices([id_parede, id_agua, id_chao], [0.1, 0.1, 0.8])[0]
            sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {tipo_terreno}, {id_andar});")
    return sql_commands

# Gerar SQL para a grade 50x50 com terrenos aleatórios
sql_commands = generate_random_terrain_inserts(id_andar)

# Imprimir comandos SQL
for sql in sql_commands:
    print(sql)
