import psycopg2
from tabulate import tabulate


# Configurações do banco de dados
DB_HOST = '172.19.0.2'
DB_NAME = 'db_pokemon'
DB_USER = 'pokemon'
DB_PASSWORD = '123456'

# Conectar ao banco de dados
conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, port=5434)
cursor = conn.cursor()


def get_narrator_dialogue():
    cursor.execute("""
        SELECT fala FROM dialogo WHERE personagem = 'Narrador' ORDER BY ordem
    """)
    dialogues = cursor.fetchall()
    if not dialogues:
        print("Nenhuma fala encontrada para o narrador.")  # Depuração
    for dialogue in dialogues:
        print(dialogue[0])
        input("Pressione Enter para continuar...")


def check_existing_player():
    cursor.execute("SELECT COUNT(*) FROM jogador")
    count = cursor.fetchone()[0]
    return count > 0
# Dicionário de tradução de tipos de Pokémon de inglês para português
tipo_traducao = {
    'fire': 'Fogo',
    'water': 'Água',
    'grass': 'Grama',
    'electric': 'Elétrico',
    'ground': 'Terra',
    'rock': 'Pedra',
    'ice': 'Gelo',
    'psychic': 'Psíquico',
    'dark': 'Sombrio',
    'fairy': 'Fada',
    'dragon': 'Dragão',
    'ghost': 'Fantasma',
    'bug': 'Inseto',
    'flying': 'Voador',
    'steel': 'Aço',
    'fighting': 'Lutador',
    'poison': 'Veneno',
    'normal': 'Normal'
}

# Dicionário de cores para os tipos de Pokémon
cor_tipo = {
    'fire': '\033[41m',    # Vermelho escuro
    'water': '\033[44m',   # Azul escuro
    'grass': '\033[42m',   # Verde escuro
    'electric': '\033[43m',# Amarelo escuro
    'ground': '\033[48;5;94m', # Marrom
    'rock': '\033[48;5;237m',   # Cinza escuro
    'ice': '\033[46m',     # Ciano escuro
    'psychic': '\033[45m', # Magenta escuro
    'dark': '\033[48;5;235m',    # Cinza escuro
    'fairy': '\033[48;5;209m',   # Rosa escuro
    'dragon': '\033[48;5;18m',  # Azul escuro
    'ghost': '\033[48;5;57m',   # Roxo escuro
    'bug': '\033[48;5;22m',     # Verde escuro
    'flying': '\033[48;5;14m',  # Azul claro
    'steel': '\033[48;5;244m',  # Cinza claro
    'fighting': '\033[41m',# Vermelho escuro
    'poison': '\033[45m',  # Magenta escuro
    'normal': '\033[37m',     # Normal cinza claro
    'reset': '\033[0m'     # Resetar a cor
}

def list_pokemon():
    cursor.execute("SELECT id_pokemon, nome, tipo FROM pokemon_base WHERE evolui_de = 'None' AND evolui_para <> 'None'")
    pokemons = cursor.fetchall()

    # Prepara os dados para a tabela
    tabela = []
    for pokemon in pokemons:
        tipo_pt = tipo_traducao.get(pokemon[2], pokemon[2])  # Traduz o tipo para português
        cor = cor_tipo.get(pokemon[2], cor_tipo['normal'])    # Define a cor para o tipo, padrão cinza
        linha = [f"{cor}{pokemon[0]}{cor_tipo['reset']}", f"{cor}{pokemon[1]}{cor_tipo['reset']}", f"{cor}{tipo_pt}{cor_tipo['reset']}"]
        tabela.append(linha)

    # Imprime a tabela formatada
    print("Escolha o Pokémon que você quer ser:")
    print(tabulate(tabela, headers=["ID", "Nome", "Tipo"], tablefmt="grid"))

    return pokemons

def create_player(pokemon_id):
    # Obter os status do Pokémon escolhido
    cursor.execute("""
        SELECT nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base,
               velocidade_base, acuracia_base, evasao_base, status_base
        FROM pokemon_base WHERE id_pokemon = %s
    """, (pokemon_id,))
    pokemon_data = cursor.fetchone()

    # Verificar se o Pokémon foi encontrado
    if pokemon_data is None:
        print("Pokémon não encontrado.")
        return

    # Criar a instância do Pokémon
    cursor.execute("INSERT INTO pokemon (id_tipo_pokemon) VALUES (1) RETURNING id_pokemon")
    new_pokemon_id = cursor.fetchone()[0]

    # Criar o jogador
    cursor.execute("""
        INSERT INTO jogador (nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, id_jogador, saldo, tam_inventario, posicao, tipo_elemental)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (1, pokemon_data[2], pokemon_data[3], pokemon_data[4],
          pokemon_data[5], pokemon_data[6], pokemon_data[7], pokemon_data[8],
          pokemon_data[9], pokemon_data[0], new_pokemon_id, 0, 20, 17902, pokemon_data[1]))

    # Criar instância de uma poção para o jogador
    cursor.execute("INSERT INTO instancia_item (id_item) VALUES (1) RETURNING id_instancia_item")
    id_instancia_item = cursor.fetchone()[0]

    # Criar o inventário
    cursor.execute("INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (%s, %s) RETURNING id_inventario", (new_pokemon_id, id_instancia_item))

    # Criar o correio
    cursor.execute("INSERT INTO correio (jogador_id, terreno_id) VALUES (%s, %s)", (new_pokemon_id, 17903))

    conn.commit()
    print(f"Você agora é o Pokémon {pokemon_data[0]}!")


# Verificar se já existe um jogador
if check_existing_player():
    choice = input("Já existe um progresso salvo. Deseja continuar com o jogador existente? (s/n): ").strip().lower()
    if choice == 's':
        print("Continuando o progresso existente...")
        pass
    else:
        # Exibir as falas do narrador
        get_narrator_dialogue()

        # Listar Pokémon e permitir escolha
        pokemons = list_pokemon()
        choice = int(input("Digite o número do Pokémon que deseja ser: "))

        # Criar jogador com base na escolha
        create_player(choice)
else:
    # Exibir as falas do narrador
    get_narrator_dialogue()

    # Listar Pokémon e permitir escolha
    pokemons = list_pokemon()
    choice = int(input("Digite o número do Pokémon que deseja ser: "))

    # Criar jogador com base na escolha
    create_player(choice)

# Fechar a conexão
cursor.close()
conn.close()
