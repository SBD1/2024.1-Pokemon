import requests

def obter_movimentos(pagina=1, limite=100):
    url = f'https://pokeapi.co/api/v2/move/?offset={((pagina - 1) * limite)}&limit={limite}'
    response = requests.get(url)
    return response.json()

def gerar_comandos_sql():
    sql_commands = []
    pagina = 1
    limite = 100  # Número de movimentos por página
    
    while True:
        movimentos_data = obter_movimentos(pagina=pagina, limite=limite)
        movimentos = movimentos_data['results']
        
        if not movimentos:
            break  # Se não houver mais movimentos, encerra o loop
        
        for movimento in movimentos:
            movimento_id = movimento['url'].split('/')[-2]
            movimento_data = requests.get(f'https://pokeapi.co/api/v2/move/{movimento_id}/').json()
            
            nome = movimento['name']
            dano = movimento_data.get('power', 0)  # Usa o valor de 'power' se disponível, senão usa 0
            acuracia = movimento_data.get('accuracy', 100)  # Usa o valor de 'accuracy' se disponível, senão usa 100
            
            # Nome do efeito: usa o texto do efeito se disponível
            nome_efeito = None
            
            # Tipo elemental: obtido a partir da propriedade 'type' dos movimentos
            tipo_elemental = movimento_data['type']['name']
            
            sql_commands.append(f"""
                INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental)
                VALUES ('{nome}', {dano}, {acuracia}, '{nome_efeito}', '{tipo_elemental}');
            """)
        
        pagina += 1  # Avança para a próxima página
        
        # Se já obtivemos pelo menos 100 habilidades, podemos parar
        if len(sql_commands) >= 100:
            break
    
    return sql_commands

# Gerar e imprimir comandos SQL
sql_commands = gerar_comandos_sql()
for command in sql_commands:
    print(command)
