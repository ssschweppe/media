def seed
  create_users
  create_catalog
  create_published_breakdown
  create_draft_breakdown
  print_summary
end
 
def create_users
  User.find_or_create_by!(email: "admin@email.com") do |u|
    u.password = ENV.fetch("ADMIN_PASSWORD", "testtest")
    u.admin = true
  end
 
  User.find_or_create_by!(email: "user@email.com") do |u|
    u.password = "testtest"
  end
 
  puts "Пользователей: #{User.count}"
end
 
def create_catalog
  @category = Category.find_or_create_by!(name: "Главный экран") do |c|
    c.description = "Решения, которые пользователь видит сразу при заходе на сайт"
  end
 
  @pattern = Pattern.find_or_create_by!(title: "Hero-блок", category: @category) do |p|
    p.summary = "Крупный заголовок, короткое описание и кнопка на первом экране"
    p.body = "Привычная схема: пользователь сразу понимает, что это за сайт и куда нажать."
  end
 
  studio = Studio.find_or_create_by!(name: "Тестовая студия") do |s|
    s.url = "https://example.com"
    s.description = "Студия для демонстрации. ее не существует..."
  end
 
  @example = Example.find_or_create_by!(name: "Тестовый сайт: цифра вместо кнопки", studio: studio) do |e|
    e.url = "https://example.com"
    e.description = "Демка"
  end
 
  # Реальный сайт без студии: показывает, что связь с студией необязательна
  Example.find_or_create_by!(name: "Room 6x8") do |e|
    e.url = "https://room6x8.com/"
    e.description = "Сайт частной галереи в Пекине"
  end
 
  @source = Source.find_or_create_by!(title: "Юзабилити") do |s|
    s.url = "https://practicum.yandex.ru/blog/kak-provodit-yuzability-testirovanie/?ysclid=muxun30h7x467465781"
    s.kind = :ab_test
  end
end
 
def create_published_breakdown
  @breakdown = Breakdown.find_or_create_by!(
    title: "Hero-блок без кнопки: цифра вместо призыва",
    pattern: @pattern,
    example: @example
  ) do |b|
    b.lead = "Сайт убрал кнопку с первого экрана и поставил на её место цифру."
    b.body = "Разбираем, что выиграл и что заплатил сайт за отказ от привычного hero-блока."
    b.demo_key = "hero_number"
    b.published_at = Time.current
  end
 
  if @breakdown.card_items.none?
    @breakdown.card_items.create!([
      { kind: :gain,          position: 1, text: "Запоминается с первой секунды", source: @source },
      { kind: :cost_user,     position: 1, text: "Непонятно, что здесь продают и куда нажимать" },
      { kind: :cost_business, position: 1, text: "Меньше кликов по главной кнопке", source: @source },
      { kind: :cost_team,     position: 1, text: "Сложнее поддерживать нестандартный блок" },
      { kind: :condition,     position: 1, text: "Оправдано, если аудитория уже знает бренд" }
    ])
  end
 
  @breakdown.quiz_questions.find_or_create_by!(prompt: "Оправдано ли это отступление для малоизвестного бренда?") do |q|
    q.justified = false
    q.explanation = "Пользователь не знает бренд, поэтому без кнопки и заголовка не понимает, что делать дальше."
  end
end
 
def create_draft_breakdown
  # published_at пустое, значит Breakdown.published его не покажет
  Breakdown.find_or_create_by!(title: "Черновик: бургер-меню на десктопе", pattern: @pattern, example: @example) do |b|
    b.lead = "Черновик для проверки фильтра published."
    b.body = "Пока не заполнено."
  end
end
 
def print_summary
  puts "Категорий: #{Category.count}, паттернов: #{Pattern.count}, примеров: #{Example.count}"
  puts "Разборов: #{Breakdown.count} (опубликовано: #{Breakdown.published.count})"
end
 
seed