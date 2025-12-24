# file: utils.sh
#!/usr/bin/env bash
set -e

#* ------ COLORS VAR ------
GREEN="\033[0;32m"
BLUE="\033[0;34m"
RED="\033[0;31m"
NC="\033[0m" # No Color
# -------------------------


#* ------ LGBT LOGS ------
info() { echo -e "${BLUE}$1${NC}"; }
success() { echo -e "${GREEN}$1${NC}"; }
error() { echo -e "${RED}$1${NC}"; }
# -----------------------


#* ------ INSTALL DEP ------
i() {
    info "Установка зависимостей..."
    pip install -r requirements.txt
    success "Установка завершена"
}
# --------------------------


#* ------ FORMAT ------
f() {
   info "Форматирование..."
   ruff format .
   success "Форматирование завершено"
}
# ---------------------


#* ------ LINTER ------
l() {
   info "Линтинг..."
   ruff check . --fix
   success "Линтинг завершен"
}
# ---------------------


#* ------ TESTS ------
t() {
   info "Тестирование..."
   pytest -q
   success "Тестирование завершено"
}
# --------------------


#* ------ DOCKER BUILD ------
db() {
   IMAGE_NAME=${1:-app}
   TAG=${2:-latest}

   info "Сборка образа: $IMAGE_NAME:$TAG..."
   docker build -t "$IMAGE_NAME:$TAG" .
   success "Сборка образа завершена"
}
# ---------------------------


#* ------ DOCKER RUN ------
dr() {
   IMAGE_NAME=${1:-app}
   TAG=${2:-latest}
   PORT=${3:-8000}

   info "Запуск контейнера..."
   docker run -it --rm -p $PORT:$PORT "$IMAGE_NAME:$TAG"
}
# -------------------------


#* ------ GIT STATUS ------
gs() {
    info "Статус:"
    git status
}
# -------------------------


#* ------ GIT COMMIT ------
gc() {
    MESSAGE="$*"
    if [ -z "$MESSAGE" ]; then
        error "Укажите сообщение коммита"
        exit 1
    fi

    info "Добавление изменений..."
    git add .

    info "Созздание коммита..."
    git commit -m "$MESSAGE"

    success "Коммит создан"
}
# -------------------------


#* ------ GIT PUSH ------
gpush() {
    BRANCH=$(git branch --show-current)

    info "Отправка в ветку: $BRANCH"
    git push origin "$BRANCH"

    success "Отправка завершена"
}
# -----------------------


#* ------ GIT PUSH ------
gpull() {
    BRANCH=$(git branch --show-current)

    info "⬇️ Получение из $BRANCH"
    git pull origin "$BRANCH"

    success "Получение завершено"
}
# -----------------------


#* ------ HELP ------
help() {
   echo "Команды:"
   echo "i                      -  Установка зависимостей"
   echo "f                      -  Форматирование кода"
   echo "l                      -  Линтинг кода"
   echo "t                      -  Тестирование кода"
   echo "db [name] [tag]        -  Сборка образа"
   echo "dr [name] [tag] [port] -  Запуск контейнера"
   echo "gs                     -  Статус vcs"
   echo "gс [message]           -  Коммит"
   echo "gpush                  -  Отправка в текущую ветку"
   echo "gpull                  -  Получение последних обновлений из текущей ветки"
}
# --------------------

# чтобы при использовании "source utils.sh" работал вызов функций напрямую
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
   # вызов функций напрямую
    "$@"
fi
