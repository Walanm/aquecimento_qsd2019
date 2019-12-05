require_relative 'receita'

def bem_vindo()
  'Bem-vindo ao My Cookbook, sua rede social de receitas culinárias!'
end

def menu()
  puts '[1] Cadastrar uma receita'
  puts '[2] Ver todas as receitas'
  puts '[3] Buscar receitas'
  puts '[4] Sair'

  print 'Escolha uma opção: '
  gets().to_i()
end

def inserir_receita
  print 'Digite o nome da sua receita: '
  nome = gets.chomp
  print 'Digite o tipo da sua receita: '
  tipo = gets.chomp
  puts "Receita de #{nome} do tipo #{tipo} cadastrada com sucesso!"
  Receita.new(nome, tipo)
end

def imprimir_receitas(receitas)
  receitas.each_with_index do |receita, index|
    puts "##{index + 1} - #{receita}"
  end
  puts 'Nenhuma receita encontrada' if receitas.empty?
end

def buscar_receitas(receitas)
  resultado = []
  print 'Digite a palavra de busca: '
  busca = gets.chomp
  receitas.each do |receita|
    if ("#{receita}".downcase.include? busca.downcase)
      resultado << receita
    end
  end
  resultado
end

puts bem_vindo()

opcao = menu()
receitas = []

while opcao != 4
  if opcao == 1
    receitas << inserir_receita
  elsif opcao == 2
    imprimir_receitas(receitas)
  elsif opcao == 3
    imprimir_receitas buscar_receitas(receitas)
  else
    puts 'Opção inválida'
  end

  opcao = menu
end

puts 'Obrigado por usar o Cookbook'