import { BusinessError } from '@kit.BasicServicesKit'
import { http } from '@kit.NetworkKit';

export const to = (p: Promise<http.HttpResponse>) => {
  return p.then(res => [null, res]).catch((err: BusinessError) => [err, null]);
};