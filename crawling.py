from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd
import re
import json
from urllib.request import urlretrieve
import ssl
ssl._create_default_https_context = ssl._create_unverified_context

def get_url(driver):

    driver.get('https://movie.naver.com/movie/running/premovie.nhn')
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')

    movie_list = soup.select('dl dt a')

    movie_url = []
    for x in movie_list:
        movie_url.append(x.get('href').split("code=")[-1])
    return movie_url

def search(driver):
    movie_name = []
    movie_genre = []
    movie_country = []
    movie_date = []
    movie_director = []
    movie_actor = []
    movie_rate = []
    movie_like = []
    movie_content = []
    movie_img = []

    movie_url = get_url(driver)
    for x in movie_url:
        url = 'https://movie.naver.com/movie/bi/mi/basic.nhn?code=' + x
        driver.get(url)
        html = driver.page_source
        soup = BeautifulSoup(html, 'html.parser')
        movie_all = soup.find('h3', class_='h_movie')
        movie_all = movie_all.find('a').text
        movie_name.append(movie_all)

        movie = soup.find('dl', class_="info_spec").span
        movie_gen = movie.find_all('a')
        movie_gen = re.sub('\s', '', movie.text)
        movie_genre.append(movie_gen)

        movie = soup.find('dl', class_="info_spec").dd.p
        movie = movie.find_all('span')
        movie = movie[1].a
        movie_country.append(movie.text)

        movie = soup.find('dl', class_="info_spec").dd.p
        movie = movie.find_all('span')
        movie_day = movie[-1]
        movie_day = re.sub('\s', '', movie_day.text).replace(".", "-")
        movie_date.append(movie_day[0:10])

        movie = soup.find('dl', class_="info_spec")
        movie = movie.find_all('dd')
        movie = movie[1].find('a')
        movie_director.append(movie.text)

        movie = soup.find('dl', class_="info_spec")
        movie = movie.find_all('dd')
        if len(movie) >= 3:
            movie = movie[2].p.find('a')
            movie_actor.append(movie.text)
        else: movie_actor.append("")

        movie = soup.find('dl', class_="info_spec")
        movie = movie.find_all('dd')
        if len(movie) >= 4:
            movie = movie[3].find('a')
            movie_rate.append(movie.text)
        else:
            movie_rate.append("")

        movie = soup.find('span', class_='exp_cnt')
        movie_like.append(movie.text[5:])

        movie = soup.find('p', class_='con_tx')
        if movie is not None:
            movie_content.append(movie.text.replace("\n", ""))
        else: movie_content.append("")

        movie = soup.find('div', class_='poster').img
        movie_img.append(movie['src'])


    movie_group = dict()
    for x in range(len(movie_url)):
        name = dict()
        name["genre"] = movie_genre[x]
        name["country"] = movie_country[x]
        name["date"] = movie_date[x]
        name["director"] = movie_director[x]
        name["actor"] = movie_actor[x]
        name["like"] = movie_like[x]
        name["story"] = movie_content[x]
        name["url"] = movie_url[x]
        name["img"] = movie_img[x]
        movie_group[movie_name[x]] = name

    # for z in movie_img:
    #     urlretrieve(z, "poster/"+ movie_name[movie_name.index(z)] +".png")

    with open('movie.json', 'w', encoding='utf-8') as make_file:
        json.dump(movie_group, make_file, ensure_ascii=False, indent="\t")


    movie_dic = {"movie_name": movie_name, "장르": movie_genre, "국가": movie_country, "개봉일": movie_date,
                 "감독": movie_director, "배우": movie_actor, "기대지수": movie_like, "movie_content": movie_content, "영화코드": movie_url}
    movie_df = pd.DataFrame(movie_dic)
    movie_df2 = movie_df.applymap(lambda x: x.replace('\xa0', '').replace('\xa9', ''))

    movie_df2.to_csv('movie.csv', encoding="cp949")


options = webdriver.ChromeOptions()
options.add_argument('headless')
driver = webdriver.Chrome(r'C:\Users\hahyu\Downloads\chromedriver_win32\chromedriver.exe', options=options)

search(driver)





