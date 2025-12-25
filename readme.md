# Инструмент для веб-скрейпинга и анализа сайтов с книгами



## Навигация
- [Вступление](#вступление)
- [Установка pyenv](#установка-pyenv)
- [Установка внешних зависимостей](#установка-внешних-зависимостей)
- [Документация к парсеру](docs/doc.md)

## Вступление

Является важной задачей для автоматизации сбора данных о литературе, авторах и издательствах. Такой инструмент позволяет извлекать структурированную информацию со страниц онлайн-каталогов.

## Запуск через Docker
```
// Создание приложения в докере
docker build -t app
// Запуск приложения через докер
docker run --rm -it app
```
## pre-commit-config.yaml
```
// Добавление в проект 
pip install pre-commit
//Установка 
pre-commit install

Теперь перед каждым `git commit` код автоматически проверяется и форматируется:
- Black — форматирование Python
- Ruff — линтинг стиля и ошибок  
- Удаление лишних пробелов
- Проверка YAML/JSON

//Проверка всех файлов
pre-commit run --all-files
//Автообновление
pre-commit autoupdate
```
## Установка pyenv
```
https://github.com/pyenv-win/pyenv-win/blob/master/README.md#quick-start
https://github.com/pyenv/pyenv
```

### Windows
```
// установка pyenv в терминале от админа
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"

// пути в PATH
%USERPROFILE%\.pyenv\pyenv-win\bin
%USERPROFILE%\.pyenv\pyenv-win\shims

// устанавливаем версию проекта
pyenv install 3.13.0

// в папке проекта установим локально версию
pyenv local 3.13.0
```

### MacOS
```
// устновка зависимостей и pyenv
brew update
brew install pyenv openssl readline sqlite3 xz zlib

// pyenv в shell (пишется в ~/.bashrc или ~/.zshrc)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

// загружаем настройки из ~/.bashrc или ~/.zshrc
source ~/.bashrc

// устанавливаем версию проекта
pyenv install 3.13.0

// в папке проекта установим локально версию
pyenv local 3.13.0
```

### Ubuntu / Debian / Mint
```
// устновка зависимостей
sudo apt update
sudo apt install -y build-essential curl git \
libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
libsqlite3-dev libffi-dev liblzma-dev tk-dev

// установка pyenv
curl https://pyenv.run | bash

// pyenv в shell (пишется в ~/.bashrc или ~/.zshrc)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

// загружаем настройки из ~/.bashrc или ~/.zshrc
source ~/.bashrc

// устанавливаем версию проекта
pyenv install 3.13.0

// в папке проекта установим локально версию
pyenv local 3.13.0
```

### Fedora / RHEL / CentOS Stream
```
// устновка зависимостей
sudo dnf groupinstall "Development Tools"
sudo dnf install curl git openssl-devel bzip2-devel \
libffi-devel zlib-devel readline-devel sqlite-devel xz-devel tk-devel

// установка pyenv
curl https://pyenv.run | bash

// pyenv в shell (пишется в ~/.bashrc или ~/.zshrc)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

// загружаем настройки из ~/.bashrc или ~/.zshrc
source ~/.bashrc

// устанавливаем версию проекта
pyenv install 3.13.0

// в папке проекта установим локально версию
pyenv local 3.13.0
```

### Arch / Manjaro
```
// устновка зависимостей
sudo pacman -S --needed base-devel curl git openssl zlib xz tk

// установка pyenv
curl https://pyenv.run | bash

// pyenv в shell (пишется в ~/.bashrc или ~/.zshrc)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

// загружаем настройки из ~/.bashrc или ~/.zshrc
source ~/.bashrc

// устанавливаем версию проекта
pyenv install 3.13.0

// в папке проекта установим локально версию
pyenv local 3.13.0
```

## Внешние зависимости

### Windows
```
pip install -r requirements.txt
```

### Other
```
source utils.sh && i
```

