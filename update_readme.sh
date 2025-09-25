#!/bin/bash

# Получаем текущую дату
CURRENT_DATE=$(date +"%d.%m.%Y")

# Считаем количество коммитов
COMMIT_COUNT=$(git rev-list --count HEAD)

# Создаем новый README
cat > README.md << EOL
# 🌼 Веб-разработка с Ромашкой

Мой учебный репозиторий для изучения фронтенд-разработки.

## 📁 Структура проектов

### Урок 1: Основы HTML и Git
- [👨‍💻 Визитка](lesson-01/cutaway/) - Персональная страница "О себе"
- [📅 Расписание дня](lesson-01/daily-schedule/) - Таблица с расписанием задач  
- [🍝 Рецепт пельменей](lesson-01/recipe-pelmeni/) - Страница с рецептом

## 🚀 Как запустить проекты
1. Открой папку проекта в VS Code
2. Установи расширение "Live Server"
3. Кликни правой кнопкой на index.html → "Open with Live Server"

## 📊 Прогресс
- Последнее обновление: $CURRENT_DATE
- Выполнено проектов: 3
- Коммитов: $COMMIT_COUNT
EOL

echo "README.md updated!"
