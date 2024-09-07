import random

id_chao = 8  
id_agua = 2  
id_parede = 3
id_pedra = 9 
id_escada = 5

id_andar = 7 

directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

def shuffle_directions():
    random.shuffle(directions)
    return directions

def is_valid(x, y, maze, size):
    return 0 < x < size - 1 and 0 < y < size - 1 and maze[x][y] == id_parede

def dfs(x, y, maze, size):
    maze[x][y] = id_chao
    
    for dx, dy in shuffle_directions():
        nx, ny = x + dx * 2, y + dy * 2
        
        if is_valid(nx, ny, maze, size):
            maze[x + dx][y + dy] = id_chao
            dfs(nx, ny, maze, size)

def generate_forest_labyrinth(id_andar, size=25):
    sql_commands = []
    

    maze = [[id_parede for _ in range(size)] for _ in range(size)]
    

    start_x, start_y = 1, 1
    dfs(start_x, start_y, maze, size)
    

    for x in range(size):
        for y in range(size):
            sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {maze[x][y]}, {id_andar});")
    

    sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({size - 2}, {size - 2}, {id_escada}, {id_andar});")
    
    return sql_commands

sql_commands = generate_forest_labyrinth(id_andar)

for sql in sql_commands:
    print(sql)
