import pandas as pd
from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd
import re
import json
from urllib.request import urlretrieve
import ssl
ssl._create_default_https_context = ssl._create_unverified_context
import warnings;warnings.filterwarnings('ignore')
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

options = webdriver.ChromeOptions()
options.add_argument('headless')
driver = webdriver.Chrome(r'C:\Users\hahyu\Downloads\chromedriver_win32\chromedriver.exe', options=options)

movies = pd.read_excel(r'C:\Users\hahyu\Desktop\movies.xlsx', encoding='utf8')
movies_df = movies['영화명'].tolist()
print(movies_df)
movie_url = []

for x in movies_df:
    url = 'https://movie.naver.com/movie/search/result.nhn?query=' + str(x) + '&section=all&ie=utf8'
    driver.get(url)
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')
    movie = soup.find('p', class_='result_thumb').img
    movie_url.append(movie.get('src'))
    print(x)

col_name = ['url']
movie_url_df = pd.DataFrame(movie_url, columns=col_name)
movie1 = pd.concat([movies,movie_url_df],axis=1)
movie1.to_csv('movie.csv', encoding="cp949")




