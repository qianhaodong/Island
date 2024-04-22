import { APP_KEY, BASE_URL, request } from '.';

// 获取首屏流行数据
const getClassicLatest = async () => {
  const url = `${BASE_URL}/classic/latest?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);
};

// 获取当前一期的上一期
const getClassicPrevious = async (index: number) => {
  const url = `${BASE_URL}/classic/${index}/previous?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);;
};

// 获取当前一期的下一期
const getClassicNext = async (index: number) => {
  const url = `${BASE_URL}/classic/${index}/next?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);;
};

// 获取期刊详情
const getClassicDetails = async (type: number, id: number) => {
  const url = `${BASE_URL}/classic/${type}/${id}?appkey=${APP_KEY}`;
  const res = await request(url);
  return JSON.parse(res);;
};

export {
  getClassicLatest,
  getClassicPrevious,
  getClassicNext,
  getClassicDetails,
}