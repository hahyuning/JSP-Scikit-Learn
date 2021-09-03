import pandas as pd
import warnings;warnings.filterwarnings('ignore')
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from konlpy.tag import *
import numpy as np
import json

def preprocess(text):
    okt = Okt()
    stop_words = ['은', '는', '이', '가', '을', '를', '좀', '잘', '그', '되다', '의', '이다',
                  '과', '도', '없다', '으로', '수', '에', '와', '한', '하다', '들', '의']
    token_str = ''
    text = okt.morphs(text, stem=True)
    # 각 줄거리를 어간 추출한 후 접미사, 접속사, 동사 제거 후 공백으로 이어 붙임
    for token in text:
        if token not in stop_words:
            token_str += ' ' + token
    return token_str

movies = pd.read_csv('contentlast.csv', encoding='cp949')
movies_df = movies[['movie_name', 'movie_content', 'url']].fillna('') #결측행 제거

movies_df['content'] = movies_df['movie_content'].apply(lambda x:preprocess(x)) #데이터 전처리

count_vect = CountVectorizer(min_df=1, ngram_range=(1,1))
# min_df : 특정 단어가 출현하는 문서의 최소 갯수(줄거리에 1번이라도 등장하면 토큰으로 사용)
# ngram_range : 단어의 묶음을 1개부터 1개까지 설정
movies_vect = count_vect.fit_transform(movies_df['content']) # BOW 인코딩 벡터 반환

cosine_sim = cosine_similarity(movies_vect, movies_vect) # 각 벡터들 사이의 코사인 유사도 구함

indices = pd.Series(movies_df.index, index=movies_df['movie_name'])

def recommendation(title, cosine_sim=cosine_sim):
    # 전체 영화에 대해 입력한 영화와의 유사도를 구한 후 리스트에 넣음
    sim_scores = list(enumerate(cosine_sim[indices[title]]))
    # 유사도 내림차순으로 영화 정렬
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)

    sim_scores = sim_scores[0:11] # 0번은 자기 자신, 1번부터 10번까지 유사도 높은 영화 10개 가져옴
    movie_indices = [i[0] for i in sim_scores] # 10개의 영화들의 인덱스 가져옴

    return movies_df['movie_name'].iloc[movie_indices] # 인덱스로 영화 찾아서 반환

movies_name = movies['movie_name'].tolist()
movie_all = {}
for x in movies_name:
    movie_index = recommendation(x).index
    movie_recom = recommendation(x).values
    movies_url = movies_df.iloc[movie_index, 2].values
    movie_dic = {}
    for y in range(11):
        movie_dic[movie_recom[y]] = movies_url[y]
    movie_all[x] = movie_dic

with open('movie_recommendation3.json', 'w', encoding='utf-8') as make_file:
    json.dump(movie_all, make_file, ensure_ascii=False, indent="\t")



