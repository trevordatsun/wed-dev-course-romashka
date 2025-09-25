#!/bin/bash

# Получаем текущую дату
CURRENT_DATE=$(date +"%d.%m.%Y")

# Считаем количество коммитов
COMMIT_COUNT=$(git rev-list --count HEAD)

# Создаем временный файл с обновленным прогрессом
cat > /tmp/progress_section.md << EOL
## 📊 Прогресс
- Последнее обновление: $CURRENT_DATE
- Выполнено проектов: 3
- Коммитов: $COMMIT_COUNT
EOL

# Если README.md существует, обновляем только секцию прогресса
if [ -f README.md ]; then
    # Создаем временный файл для нового README
    TEMP_README=$(mktemp)
    
    # Используем awk для замены секции прогресса
    awk '
    /^## 📊 Прогресс$/ { 
        skip=1; 
        # Вставляем новую секцию прогресса
        system("cat /tmp/progress_section.md")
        next 
    }
    /^## [^#]/ && skip { 
        skip=0 
    }
    !skip { 
        print 
    }
    ' README.md > "$TEMP_README"
    
    # Если секция прогресса не была найдена, добавляем ее в конец
    if ! grep -q "## 📊 Прогресс" README.md; then
        echo "" >> "$TEMP_README"
        cat /tmp/progress_section.md >> "$TEMP_README"
    fi
    
    # Заменяем старый README новым
    mv "$TEMP_README" README.md
    echo "README.md updated while preserving manual changes!"
else
    # Если README не существует, создаем полный
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

$(cat /tmp/progress_section.md)
EOL
    echo "README.md created from scratch!"
fi

# Удаляем временные файлы
rm -f /tmp/progress_section.md
