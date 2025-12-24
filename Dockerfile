# file: Dockerfile


# используемый образ
FROM python:3.11-slim

# рабочая директория в контейнере
WORKDIR /app

# копируем файл с указанными зависимоятми
COPY requirements.txt .
# установка зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# копируем проект
COPY . .

# если тесты не пройдут, то собрать образ не получиться
# RUN ruff check . --fix
# нам шибко не нужно форматить код в контейнере, но если надо будет
#* RUN ruff format .

# запуск
CMD [ "python", "app/main.py" ]
