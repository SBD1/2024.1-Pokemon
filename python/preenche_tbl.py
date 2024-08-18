import requests
import time


def generate_sql_insert(pokemon_data):
    return f"""
INSERT INTO pokemon (nome, tipo, nivel_base, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES (
    '{pokemon_data['nome']}',
    '{pokemon_data['tipo']}',
    {pokemon_data['vida_base']},
    {pokemon_data['ataque_fisico_base']},
    {pokemon_data['defesa_fisica_base']},
    {pokemon_data['ataque_especial_base']},
    {pokemon_data['velocidade_base']},
    {pokemon_data['acuracia_base']},
    {pokemon_data['evasao_base']},
    '{pokemon_data['status_base']}',
    '{pokemon_data['evolui_de']}',
    '{pokemon_data['evolui_para']}'
);
"""


def fetch_pokemon_data(pokemon_id):
    time.sleep(1)
    # Obter dados do Pokémon
    url = f'https://pokeapi.co/api/v2/pokemon/{pokemon_id}/'
    response = requests.get(url)
    data = response.json()

    nome = data['name']
    tipos = [t['type']['name'] for t in data['types']]
    stats = {stat['stat']['name']: stat['base_stat'] for stat in data['stats']}
    tipo = tipos[0] if tipos else 'unknown'

    # Obter dados da espécie para acessar a cadeia evolutiva
    species_url = f"https://pokeapi.co/api/v2/pokemon-species/{pokemon_id}/"
    species_response = requests.get(species_url)
    species_data = species_response.json()

    evolution_chain_url = species_data['evolution_chain']['url']
    evolution_response = requests.get(evolution_chain_url)
    evolution_data = evolution_response.json()

    # Encontrar a cadeia evolutiva para determinar quem evolui de/para quem
    evolui_de = None
    evolui_para = None

    chain = evolution_data['chain']
    
    if chain['species']['name'] == nome:
        # Primeira fase da cadeia
        evolui_para = chain['evolves_to'][0]['species']['name'] if chain['evolves_to'] else None
    else:
        # Verificar se o Pokémon é uma evolução intermediária
        for evolution in chain['evolves_to']:
            if evolution['species']['name'] == nome:
                evolui_de = chain['species']['name']
                evolui_para = evolution['evolves_to'][0]['species']['name'] if evolution['evolves_to'] else None
                break
            for next_evolution in evolution['evolves_to']:
                if next_evolution['species']['name'] == nome:
                    evolui_de = evolution['species']['name']
                    evolui_para = None
                    break

    return {
        'nome': nome,
        'tipo': tipo,
        'vida_base': stats.get('hp', 0),
        'ataque_fisico_base': stats.get('attack', 0),
        'defesa_fisica_base': stats.get('defense', 0),
        'ataque_especial_base': stats.get('special-attack', 0),
        'velocidade_base': stats.get('speed', 0),
        'acuracia_base': 100,  
        'evasao_base': 0,      
        'status_base': 'normal',
        'evolui_de': evolui_de,
        'evolui_para': evolui_para
    }


# Gerar a lista pokemon_ids de 1 a 151
pokemon_ids = list(range(1, 152))

for pokemon_id in pokemon_ids:
    pokemon_data = fetch_pokemon_data(pokemon_id)
    sql_command = generate_sql_insert(pokemon_data)
    print(sql_command)
