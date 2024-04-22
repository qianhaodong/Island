// 1、引入http
import { http } from '@kit.NetworkKit'
import { to } from '../utils';

export const BASE_URL = 'http://bl.talelin.com/v1';
export const APP_KEY = 'AbhC31IG7ruCDp57';

class Header {
  public contentType: string;

  constructor(contentType: string) {
    this.contentType = contentType;
  }
}

// 2、创建http对象
const httpRequest = http.createHttp();

export const request = async (url: string, method: http.RequestMethod = http.RequestMethod.GET, data?: Record<string, number | string>) => {
  const options: http.HttpRequestOptions = {
    method,
    header: new Header('application/json'),
  };
  if (method === http.RequestMethod.POST) {
    options.extraData = data;
  }
  const result = await to(httpRequest.request(url, options));

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

// 点赞
const likeClick = async (params: Record<string, number | string>) => {
  const url = `${BASE_URL}/like?appkey=${APP_KEY}`;
  const res = await request(url, http.RequestMethod.POST, params);
  return JSON.parse(res);
};

// 取消点赞
const likeClickCancel = async (params: Record<string, number | string>) => {
  const url = `${BASE_URL}/like/cancel?appkey=${APP_KEY}`;
  const res = await request(url, http.RequestMethod.POST, params);
  return JSON.parse(res);
};

export {
  likeClick,
  likeClickCancel,
}