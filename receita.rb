require 'json'
require 'sqlite3'

class Receita
  attr_accessor :nome, :tipo

  def initialize(nome:, tipo:)
    @nome = nome
    @tipo = tipo
  end

  def to_s
    "#{nome} - #{tipo}"
  end

  def to_json(options = {})
    { nome: nome, tipo: tipo }.to_json(options)
  end

  def include?(termo)
    termo.downcase!
    nome.downcase.include?(termo)
  end

  def self.busca(termo)
    db = SQLite3::Database.open('cookbook.db')
    termo = '%' + termo + '%'
    receitas_encontradas = db.execute <<-SQL, *termo
      select * from receitas where nome LIKE ?
    SQL
    receitas_encontradas.map do |nome, tipo|
      Receita.new(nome: nome, tipo: tipo)
    end
  end

  def self.inserir(nome, tipo)
    db = SQLite3::Database.open('cookbook.db')
    db.execute <<-SQL, *nome, tipo
      insert into receitas (nome, tipo) values (?, ?)
    SQL
    Receita.new(nome: nome, tipo: tipo)
  end

  def self.load
    db = SQLite3::Database.open('cookbook.db')
    receitas = db.execute <<-SQL
      select * from receitas
    SQL
    receitas.map do |nome, tipo|
      Receita.new(nome: nome, tipo: tipo)
    end
  end
end