# 2024.1-Pokemon

Tabela de conteúdos
=================
<!--ts-->
   * [Sobre o Jogo](#Sobre-o-jogo)
   * [Requisitos](#Requisitos)
   * [Como executar o jogo](#Como-executar-o-jogo)
   * [Contribuidores](#Contribuidores)
     
<!--te-->

## Sobre o jogo

O projeto tem como objetivo a criação de um jogo baseado no Pokemon Mistery Dungeons, onde o jogador controla um Pokemón com o objetivo de explorar dungeons e completar missões.

## Requisitos

## Como executar o jogo

Para jogar a aplicação é necessário seguir com os passos abaixo:

Clone o repositório
```
git clone https://github.com/SBD1/2024.1-Pokemon.git
```

Suba o docker
```
docker compose up -d --build
```

Criar venv na pasta python
```
python3 -m venv venv
```
Ativa o venv
```
source venv/bin/activate
```
Instale as dependências
```
pip install pygame
pip install psycopg2-binary
pip install tabulate
```

Rode a aplicação
```
python python/game.py
```

Obs.: Alguns sistemas operacionais não precisam fazer o passo de criação do venv e pode pular direto para o passo de instalar as dependências, depois que já tiver subido o docker.

## Contribuidores

<table>
  <tr>
    <td align="center"><a href="https://github.com/GabrielMR360"><img style="border-radius: 50%;" src="https://github.com/GabrielMR360.png" width="100px;" alt=""/><br /><sub><b>Gabriel Marcolino</b></sub></a><br />
    <td align="center"><a href="https://github.com/ShaineOliveira"><img style="border-radius: 50%;" src="https://github.com/ShaineOliveira.png" width="100px;" alt=""/><br /><sub><b>Shaíne Oliveira</b></sub></a><br />
    <td align="center"><a href="https://github.com/JoseFilipi"><img style="border-radius: 50%;" src="https://github.com/JoseFilipi.png" width="100px;" alt=""/><br /><sub><b>José Filipi</b></sub></a><br />
    <td align="center"><a href="https://github.com/LeoFacB"><img style="border-radius: 50%;" src="https://github.com/LeoFacB.png" width="100px;" alt=""/><br /><sub><b>Leonardo Bonetti</b></sub></a><br />
  </tr>
</table>

## Videos de Apresentação dos Módulos

| Módulo | Link do Vídeo                                                     | Data de Entrega |
| :----: | ----------------------------------------------------------------- | --------------- |
|   1    | [Vídeo de Apresentação do Módulo 1](https://youtu.be/Rox907B7eAI) | 17/07/2024      |
|   2    | [Vídeo de Apresentação do Módulo 2](https://www.youtube.com/watch?v=88DrSI6KnoY)   |  19/08/2024     |
|   3    | [Vídeo de Apresentação do Módulo 3](https://www.youtube.com/watch?v=OPj2FF_moPY)       |  09/09/2024               |
