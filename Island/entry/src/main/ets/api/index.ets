// 1、引入http
import { http } from '@kit.NetworkKit'
import { to } from '../utils';

const BASE_URL = 'http://bl.talelin.com/v1';
const APP_KEY = 'AbhC31IG7ruCDp57';

// 2、创建http对象
const httpRequest = http.createHttp();

const request = async (url: string) => {
  const result = await to(httpRequest.request(url));

  // TODO - 判断状态码
  if (result[0]) {
    console.error(JSON.stringify(result[0]));
    throw new Error('[request]:httpRequest.request:Error');
  }

  if ((result[1] as http.HttpResponse).responseCode !== 200) {
    throw new Error('[request]:http.HttpResponse.responseCode !== 200');
  }

  return (result[1] as http.HttpResponse).result as string;
};

// 获取首屏流行数据
const getClassicLatest = async () => {
  const url = `${BASE_URL}/classic/latest?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);
};

// 获取下一个流行数据
const getClassicPrevious = async (index: number) => {
  const url = `${BASE_URL}/classic/${index}/previous?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);;
};

// 获取精选书单
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

export {
  getClassicLatest,
  getClassicPrevious,
  getHotBookList,
  getHotSearchList,
  getBookDetails,
  getSearchResult,
}