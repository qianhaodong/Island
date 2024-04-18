// 获取精选书单
import { APP_KEY, BASE_URL, request } from '.';

const getHotBookList = async () => {
  const url = `${BASE_URL}/book/hot_list?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);
};

// 获取热门搜索
const getHotSearchList = async () => {
  const url = `${BASE_URL}/book/hot_keyword?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res).hot;
};

// 获取书单详情
const getBookDetails = async (id: number) => {
  const url = `${BASE_URL}/book/${id}/detail?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);
};

// 获取搜索内容
const getSearchResult = async (query: string) => {
  const url = `${BASE_URL}/book/search?summary=1&q=${query}&appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res).books;
};

// 获取书籍点赞情况
const getBookLikeStatus = async (id: number) => {
  const url = `${BASE_URL}/book/${id}/favor?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);
};

// 获取书籍评论
const getBookShortComment = async (id: number) => {
  const url = `${BASE_URL}/book/${id}/short_comment?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);
};

export {
  getHotBookList,
  getHotSearchList,
  getBookDetails,
  getSearchResult,
  getBookLikeStatus,
  getBookShortComment,
}