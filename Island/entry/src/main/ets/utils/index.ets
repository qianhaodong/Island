import { BusinessError } from '@kit.BasicServicesKit'
import { http } from '@kit.NetworkKit';

export const to = (p: Promise<http.HttpResponse>) => {
  /*const p1: Promise<[null | BusinessError, null | http.HttpResponse]> = new Promise((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(['custom-error', null])
    }, 1000)
  })

  return p1;*/
  return p.then(res => [null, res]).catch((err: BusinessError) => [err, null]);
};