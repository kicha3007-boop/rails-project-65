# Доска объявлений

[![hexlet-check](https://github.com/kicha3007-boop/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kicha3007-boop/rails-project-65/actions)
[![CI](https://github.com/kicha3007-boop/rails-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/kicha3007-boop/rails-project-65/actions/workflows/ci.yml)

Сервис-аналог Avito: пользователи размещают объявления с фотографией, каждое проходит премодерацию. Администраторы публикуют объявление, возвращают его на доработку или отправляют в архив.

Учебный проект Хекслета: https://ru.hexlet.io/programs/rails

## Возможности

- Вход через GitHub (OmniAuth)
- Объявления с категорией и фотографией (Active Storage), проверка размера и формата
- Жизненный цикл объявления на конечном автомате (AASM): черновик → модерация → опубликовано / отклонено, архив из любого состояния
- Профиль `/profile` со своими объявлениями и действиями над ними
- Админка `/admin`: модерация, все объявления, категории; права через Pundit
- Поиск и фильтры (Ransack), пагинация (Kaminari)

## Установка и запуск

```bash
git clone https://github.com/kicha3007-boop/rails-project-65.git
cd rails-project-65
make setup   # .env из .env.example, зависимости, Tailwind, база, категории
make start   # http://localhost:3000
```

Для входа через GitHub заполните в `.env` переменные `GITHUB_CLIENT_ID` и `GITHUB_CLIENT_SECRET` из OAuth-приложения GitHub (callback: `http://localhost:3000/auth/github/callback`).

## Разработка

```bash
make test    # тесты контроллеров
make lint    # rubocop и herb-lint (нужен Node.js для npx)
```

## Деплой

Продакшен ожидает переменные окружения `DATABASE_URL` (PostgreSQL), `SECRET_KEY_BASE`, `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET` и, по желанию, `SENTRY_DSN` для отправки ошибок в Bugsink.

<details>
<summary>Автоматические тесты Хекслета</summary>

Тесты запускаются на каждый коммит. За запуск отвечает файл `.github/workflows/hexlet-check.yml` — не удаляйте и не переименовывайте ни его, ни репозиторий.

</details>
