import requests


def generate_sql_insert(pokemon_data):
    return f"""
INSERT INTO pokemon (nome, tipo, nivel_base, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base)
VALUES (
    '{pokemon_data['nome']}',
    '{pokemon_data['tipo']}',
    {pokemon_data['nivel_base']},
    {pokemon_data['vida_base']},
    {pokemon_data['ataque_fisico_base']},
    {pokemon_data['defesa_fisica_base']},
    {pokemon_data['ataque_especial_base']},
    {pokemon_data['velocidade_base']},
    {pokemon_data['acuracia_base']},
    {pokemon_data['evasao_base']},
    '{pokemon_data['status_base']}'
);
"""


def fetch_pokemon_data(pokemon_id):
    url = f'https://pokeapi.co/api/v2/pokemon/{pokemon_id}/'
    response = requests.get(url)
    data = response.json()

    
    nome = data['name']
    tipos = [t['type']['name'] for t in data['types']]
    
    
    stats = {stat['stat']['name']: stat['base_stat'] for stat in data['stats']}
    
    
    tipo = tipos[0] if tipos else 'unknown'
    
    return {
        'nome': nome,
        'tipo': tipo,
        'nivel_base': 50,  
        'vida_base': stats.get('hp', 0),
        'ataque_fisico_base': stats.get('attack', 0),
        'defesa_fisica_base': stats.get('defense', 0),
        'ataque_especial_base': stats.get('special-attack', 0),
        'velocidade_base': stats.get('speed', 0),
        'acuracia_base': 100,  
        'evasao_base': 0,      
        'status_base': 'normal'  
    }



pokemon_ids = [
    1,  
    4,  
    7,  
    10, 
    13, 
    16, 
    19, 
    25, 
    39, 
    52, 
    63, 
    66, 
    74, 
    77, 
    82, 
    92, 
    95, 
    100 
]


for pokemon_id in pokemon_ids:
    pokemon_data = fetch_pokemon_data(pokemon_id)
    sql_command = generate_sql_insert(pokemon_data)
    print(sql_command)
