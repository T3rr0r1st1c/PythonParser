# file: app/main.py

import json

import requests
from bs4 import BeautifulSoup
from fake_useragent import UserAgent


def main():
   # получим от пользователя название книги и заменим пробелы в строке
   inputText = input("✏️  Введите название книги: ")
   queryStr = inputText.replace(" ", "+")

   # массив веб-ресурсов и их книг
   resBooks = {
      "litres": [],
      "chitai-gorod": []
   }

   # запрос на веб-ресурс Литрес
   # пример запроса найденный в веб тулзах Литреса:
   # https://api.litres.ru/foundation/api/search?is_for_pda=true&limit=24&offset=0&q=война+и+мир&show_unavailable=false&types=text_book&types=audiobook&types=podcast&types=podcast_episode&types=webtoon
   # попробовав отправить запрос в Insomnia(Postman) без дополнительных заголовков, мы получили ответ 200 и json объект
   # поэтому можно отправлять запрос на этот адрес, заменив параметр q
   # также заменим параметр limit для получения только 5 товаров
   # offset можно не трогать, т.к. нам в любом случае необходимо найти 5 первых товаров, которые подходят по поисковой строке
   urlLitres = "https://api.litres.ru/foundation/api/search"
   paramsLitres = {
      "is_for_pda": "true",
      "limit": 5,
      "offset": 0,
      "q": queryStr,
      "show_unavailable": "false",
      "types": "text_book"
   }
   resLitres = requests.get(urlLitres, params=paramsLitres)

   # парсим в json и получаем массив книг
   booksLitres = resLitres.json()["payload"]["data"]

   # пройдемся по массиву книг и получим основные данные (наименование, автор, рейтинг, стоимость)
   for item in booksLitres:
      book = item["instance"]
      title = book.get("title", "Без названия")
      
      # выберет первого автора
      author = "Неизвестный автор"
      for person in book.get("persons", []):
         if person.get("role") == "author":
            author = person.get("full_name", author)
            break
      
      rating_data = book.get("rating", {})
      rating = rating_data.get("rated_avg", "Нет оценок") if rating_data.get("rated_total_count", 0) > 0 else "Нет оценок"
      
      price = book.get("prices", {}).get("final_price", "Не указана")
      currency = book.get("prices", {}).get("currency", "")

      resBooks["litres"].append({
         "title": title,
         "author": author,
         "rating": rating,
         "price": f"{price} {currency}"
      })

   # отправим запрос на веб-ресурс Читай город
   # https://www.chitai-gorod.ru/search?phrase=Война+и+мир

   urlCg = "https://www.chitai-gorod.ru/search"
   paramsCg = {
        "phrase": inputText  # можно и queryStr, сайт понимает пробелы
      }

   headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                  "AppleWebKit/537.36 (KHTML, like Gecko) "
                  "Chrome/120.0.0.0 Safari/537.36"
}

   resCg = requests.get(urlCg, params=paramsCg, headers=headers)
   htmlCg = resCg.text
   soupCg = BeautifulSoup(htmlCg, "html.parser")

   # На сайте книги обычно в article.product-card
   cardsCg = soupCg.find_all("article", class_="product-card")[:5]

   for card in cardsCg:
    # название
    title_tag = card.find("a", class_="product-card__title")
    title = title_tag.get_text(strip=True) if title_tag else "Без названия"

    # автор
    author_tag = card.find("span", class_="product-card__subtitle")
    author = author_tag.get_text(strip=True) if author_tag else "Неизвестный автор"

    # цена (текущая)
    price_tag = card.find("span", class_="product-mini-card-price__price")
    price = price_tag.get_text(strip=True) if price_tag else "Не указана"

    resBooks["chitai-gorod"].append({
        "title": title,
        "author": author,
        "rating": "Нет данных",
        "price": price
    })


   print(resBooks)

if __name__ == "__main__":
    main()
