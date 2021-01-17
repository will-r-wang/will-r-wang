require_relative 'game'

class MarkdownGenerator
  ISSUE_BASE_URL = 'https://github.com/will-r-wang/will-r-wang/issues/new'
  ISSUE_BODY = 'body=Just+push+%27Submit+new+issue%27+without+modifying+the+title.+The+README+will+be+updated+after+approximately+30+seconds.'

  def initialize(game:)
    @game = game
  end

  def readme
    markdown = <<~HTML
        # Hey 👋, I'm Will

        <!-- --- Social Icons --- -->
        [![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?style=flat&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/will-r-wang/)](https://www.linkedin.com/in/will-r-wang/) 
        [![Hey Email](https://img.shields.io/badge/Hey-5522fa?style=flat&logo=Hey&logoColor=white&link=mailto:william.wang@hey.com)](mailto:william.wang@hey.com) 
        [![Goodreads](https://img.shields.io/badge/Goodreads-9e7000?style=flat&logo=Goodreads&logoColor=white&link=http://goodreads.com/willrwang)](http://goodreads.com/willrwang)  

        <!-- --- About Me --- -->	
        I'm currently working as a developer intern on the <a title='Installments' target="_blank" rel="noopener" href="https://www.shopify.com/shop-pay-installments">Shop Pay Installments</a> team and pursuing my B.C.S Honours at Carleton University as part of Shopify's <a title='Dev Degree' target="_blank" rel="noopener" href="https://devdegree.ca/">Dev Degree</a> program. In my spare time, I like to run, code, read, blog, and make music. Sometimes, I dabble in open source and compete in hackathons.  

        <!--START_SECTION:waka-->
        ```text
        Other        24 hrs 9 mins   ███████████▒░░░░░░░░░░░░░   45.82 % 
        Ruby         20 hrs 1 min    █████████▒░░░░░░░░░░░░░░░   37.99 % 
        Python       5 hrs 57 mins   ██▓░░░░░░░░░░░░░░░░░░░░░░   11.30 % 
        Markdown     38 mins         ▒░░░░░░░░░░░░░░░░░░░░░░░░   01.21 % 
        JavaScript   30 mins         ▒░░░░░░░░░░░░░░░░░░░░░░░░   00.95 % 
        ```
        <!--END_SECTION:waka-->

        ## Community Ultimate Tic Tac Toe
        Welcome to our community game of Ultimate Tic Tac Toe!  

        ### Rules:
        Win three games of Tic Tac Toe in a row. You may only play  
        in the big field that corresponds to the last small field your  
        opponent played. When your are sent to a field that is already  
        decided, you can choose freely. [\[1\]](https://bejofo.net/ttt)  

        Click on a 👾 and press submit issue to make a move.  
    HTML
    markdown.concat("\n\nNext to move: #{@game.turn.even? ? '❌' : '⭕️'}\n")
    markdown.concat(generate_game_board)
    markdown.concat("\nSee the original project here: https://github.com/will-r-wang/Ultimate-Tic-Tac-Toe  ")
    markdown.concat("\nBuilt with [@sayohnahilan](https://github.com/sayohnahilan)")
    markdown.concat("\nInspired by: [Community Connect Four Game!](https://github.com/JonathanGin52/JonathanGin52/) - [@JonathanGin52](https://github.com/jonathangin52)")
    markdown
  end

  def generate_game_board
    headers = ' |0|1|2|3|4|5|6|7|8'
    game_board = "|#{headers}|\n|-|-|-|-|-|-|-|-|-|-|\n"

    0.upto(8) do |row|
      format = (0...9).map do |col|
        if @game.valid_moves.include?("#{row}|#{col}")
          "[👾](#{ISSUE_BASE_URL}?title=move%7C#{row}%7C#{col}&#{ISSUE_BODY})"
        elsif @game.board[row][col] == 'X'
          '❌'
        elsif @game.board[row][col] == 'O'
          '⭕️'
        else
          ' '
        end
      end
      game_board.concat("|#{row}|#{format.join('|')}|\n")
    end
    game_board
  end
end
