This is a challenge by Coodesh

Mobile Challenge 🏅 2022 - Dictionary

O objetivo deste projeto é apresentar um aplicativo que liste algumas palavras da lingua inglesa, mostre seus significados e pronúcia, assim como poder adicionar e remover de sua lista de palavras favoritas e apresentar um histórico das palavras vistas por você anteriormente.

As tecnologias utilizadas para este desafio foram as seguintes:
- Linguagem: Dart versão 3.1.2
- Framework: Flutter versão 3.13.4
- Banco de dados NoSQL: Isar versão 3.1.0+1
- Gerenciamento de estado: MobX
- Backend: Firebase
- Gerenciamento HTTP: plugin http versão 1.1.0

Como instalar o projeto:
- Instale o SDK do Flutter versão 3.13.4
- Baixe o conteúdo deste repositório da branch master
- Rode o seguinte comando no terminal dentro da pasta do projeto: flutter pub get
- Rode o seguinte comando no terminal dentro da pasta do projeto para gerar os arquivos necessários: dart run build_runner build --delete-conflicting-outputs

Link para o video de apresentação: https://www.loom.com/embed/e8093956fadb436fa0d78e87ce157047

A seguir, eu descreverei o processo de decisão de alguns métodos e tecnologias usadas no desafio:

Obrigatório 1. Para este item, eu decidi realizar o desafio usando uma base de dados local dado o prazo curto do desafio. Dessa forma, eu consegui agilizar e implementar todos os itens obrigatórios além de poder caprichar nas telas.

O plugin utilizado pro gerenciamento da base de dados local foi o Isar, que oferece um banco de dados NoSQL muito rápido.

Obrigatório 2. Para o cacheamento, o banco NoSQL do Isar também foi utilizado e eu aproveitei a propriedade que identifica o item no histórico para fazer o cacheamento e não repetir a requisição para a Words API.

Obrigatório 3. Eu segui o Wireframe proposto e mudei de local alguns dos componentes mantendo as funcionalidades pedidas e transformei em uma PageView as telas de Word List, History e Favorites, justamente para melhorar a transição entre essas telas e oferecer uma experiência mais fluída pro usuário.

Diferencial 1: Eu implementei o tocador de audio porém não o sugerido pelo desafio. Eu usei um plugin de TTS para reproduzir o texto das palavras em um audio

Diferencial 2: Em relação a injeção de dependência, eu não utilizei um plugin externo, em vez disso eu fiz as injeções via o construtor das classes.

Diferencial 3: Infelizmente eu não consegui desenvolver uma estratégia de testes automatizados por conta do prazo, porém caso o prazo não fosse um limitador, eu desenvolveria um teste de unidade para cada método da camada de Repository do projeto e da camada de dados. Os testes E2E eu faria na camada de UseCase para validar as regras determinadas assim como a checagem dos dados vindos da repository, dando uma segurança maior na integração dessas duas camadas até a camada de UI.

Diferencial 4: Para a implementação do login eu utilizei o serviço do Firebase Authentication, pois ele oferece uma solução de autenticação completa e segura, economizando meu tempo e focando em desenvolver outras funcionalidades.


