import math
id_chao = 8  
id_parede = 3
id_andar_boss = 8 
def generate_boss_pit(id_andar, diameter=15):
    sql_commands = []
    
    center = diameter // 2
    
    for x in range(diameter):
        for y in range(diameter):
    
            distance = math.sqrt((x - center) ** 2 + (y - center) ** 2)
            
    
            if distance > center:
                sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_parede}, {id_andar});")
            else:
        
                sql_commands.append(f"INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES ({x}, {y}, {id_chao}, {id_andar});")
    
    return sql_commands
sql_commands = generate_boss_pit(id_andar_boss)
for sql in sql_commands:
    print(sql)
