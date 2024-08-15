import psycopg2

# Configurações do banco de dados
DB_HOST = '172.22.0.1'
DB_NAME = 'pokemon'
DB_USER = 'empreender_local'
DB_PASSWORD = '123456'

# Conectar ao banco de dados
conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
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


# Função para listar os Pokémon disponíveis
def list_pokemon():
    cursor.execute("SELECT id_pokemon, nome FROM pokemon_base")
    pokemons = cursor.fetchall()
    print("Escolha o Pokémon que você quer ser:")
    for pokemon in pokemons:
        print(f"{pokemon[0]}: {pokemon[1]}")
    return pokemons

# Função para criar o jogador e associar o Pokémon
def create_player(pokemon_id):
    # Obter os status do Pokémon escolhido
    cursor.execute("""
        SELECT nome, nivel_base, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base,
               velocidade_base, acuracia_base, evasao_base, status_base
        FROM pokemon_base WHERE id_pokemon = %s
    """, (pokemon_id,))
    pokemon_data = cursor.fetchone()

    # Criar a instância do Pokémon
    cursor.execute("INSERT INTO pokemon (id_tipo_pokemon) VALUES (1) RETURNING id_pokemon")
    new_pokemon_id = cursor.fetchone()[0]

    # Criar o inventário
    cursor.execute("INSERT INTO inventario DEFAULT VALUES RETURNING id_inventario")
    inventario_id = cursor.fetchone()[0]

    # Criar o jogador
    cursor.execute("""
        INSERT INTO jogador (nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, id_pokemon, id_inventario, id_pokemon_base)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (pokemon_data[1], pokemon_data[2], pokemon_data[3], pokemon_data[4],
          pokemon_data[5],
          pokemon_data[6], pokemon_data[7], pokemon_data[8], pokemon_data[9],
          pokemon_data[0], new_pokemon_id, inventario_id, pokemon_id))

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
