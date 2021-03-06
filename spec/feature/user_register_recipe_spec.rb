require 'rails_helper'

feature 'User register recipe' do
  scenario 'view send link' do
    visit root_path

    expect(page).to have_link('Home', href: root_path)
    expect(page).to have_link('Cadastrar receita', href: new_recipe_path)
  end

  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Arabe')

    # simula a ação do usuário
    visit root_path
    click_on 'Cadastrar receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto da Receita', Rails.root.join('spec', 'support', 'fixtures', 'Feijoada.jpg'))
    click_on 'Enviar'


    # expectativas
    expect(page).to have_css('h2', text: 'Tabule')
    expect(page).to have_css('h5', text: 'Detalhes')
    expect(page).to have_css('li', text: 'Entrada')
    expect(page).to have_css('li', text: 'Arabe')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: "45 minutos")
    expect(page).to have_css('h5', text: 'Ingredientes')
    expect(page).to have_css('li', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h5', text: 'Como Preparar')
    expect(page).to have_css('li', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    # simula a ação do usuário
    visit root_path
    click_on 'Cadastrar receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
