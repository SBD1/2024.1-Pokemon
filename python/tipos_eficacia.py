import requests

# Função para obter dados e gerar comandos SQL
def gerar_comandos_sql():
    tipos = requests.get('https://pokeapi.co/api/v2/type/').json()['results']
    
    sql_commands = []
    
    for tipo in tipos:
        tipo_id = tipo['url'].split('/')[-2]
        tipo_data = requests.get(f'https://pokeapi.co/api/v2/type/{tipo_id}/').json()
        
        for t in tipo_data['damage_relations']['double_damage_to']:
            sql_commands.append(f"""
                INSERT INTO public.interacao (valor, tipo_atacante, tipo_defensor)
                VALUES (2.0, '{tipo['name']}', '{t['name']}');
            """)
        
        for t in tipo_data['damage_relations']['half_damage_to']:
            sql_commands.append(f"""
                INSERT INTO public.interacao (valor, tipo_atacante, tipo_defensor)
                VALUES (0.5, '{tipo['name']}', '{t['name']}');
            """)
        
        for t in tipo_data['damage_relations']['no_damage_to']:
            sql_commands.append(f"""
                INSERT INTO public.interacao (valor, tipo_atacante, tipo_defensor)
                VALUES (0.0, '{tipo['name']}', '{t['name']}');
            """)
    
    return sql_commands

# Gerar e imprimir comandos SQL
sql_commands = gerar_comandos_sql()
for command in sql_commands:
    print(command)
