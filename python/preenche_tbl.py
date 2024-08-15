import requests

# Função para gerar o comando SQL de inserção
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


# Obtém dados de Pokémon da API
def fetch_pokemon_data(pokemon_id):
    url = f'https://pokeapi.co/api/v2/pokemon/{pokemon_id}/'
    response = requests.get(url)
    data = response.json()

    # Extrai as informações necessárias
    nome = data['name']
    tipos = [t['type']['name'] for t in data['types']]
    
    # Obtém dados dos stats
    stats = {stat['stat']['name']: stat['base_stat'] for stat in data['stats']}
    
    # Considera apenas o primeiro tipo para simplificação
    tipo = tipos[0] if tipos else 'unknown'
    
    return {
        'nome': nome,
        'tipo': tipo,
        'nivel_base': 50,  # Valor genérico, pois o nível não está na API
        'vida_base': stats.get('hp', 0),
        'ataque_fisico_base': stats.get('attack', 0),
        'defesa_fisica_base': stats.get('defense', 0),
        'ataque_especial_base': stats.get('special-attack', 0),
        'velocidade_base': stats.get('speed', 0),
        'acuracia_base': 100,  # Valor genérico
        'evasao_base': 0,      # Valor genérico
        'status_base': 'normal'  # Valor genérico
    }

# Lista de Pokémon da primeira geração (exemplos)
pokemon_ids = [
    1,  # Bulbasaur
    4,  # Charmander
    7,  # Squirtle
    10, # Caterpie
    13, # Weedle
    16, # Pidgey
    19, # Rattata
    25, # Pikachu
    39, # Jigglypuff
    52, # Meowth
    63, # Abra
    66, # Machop
    74, # Geodude
    77, # Ponyta
    82, # Magnemite
    92, # Gastly
    95, # Onix
    100 # Voltorb
]

# Gera e imprime os comandos SQL
for pokemon_id in pokemon_ids:
    pokemon_data = fetch_pokemon_data(pokemon_id)
    sql_command = generate_sql_insert(pokemon_data)
    print(sql_command)
