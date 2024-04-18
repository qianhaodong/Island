import { APP_KEY, BASE_URL, request } from '.';

// 获取喜欢的书籍数量
const getBookLikeNums = async () => {
  const url = `${BASE_URL}/book/favor/count?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res).count;
};

// 获取喜欢的期刊
const getClassicLikeList = async () => {
  const url = `${BASE_URL}/classic/favor?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);;
};

export {
  getBookLikeNums,
  getClassicLikeList,
}