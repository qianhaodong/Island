import { preferences } from '@kit.ArkData'

const SEARCH_KEY = 'SEARCH_KEY';

export class StoreManager {
  static context: Context

  static getStore(context: Context = StoreManager.context) {
    const store = preferences.getPreferencesSync(context, { name: 'store_cache' });
    return store;
  }

  static async setHistorySearchList(data: string[]) {
    const store = StoreManager.getStore();
    store.putSync(SEARCH_KEY, JSON.stringify(data));
    await store.flush();
  }

  static getHistorySearchList() {
    const store = StoreManager.getStore();
    const data = store.getSync(SEARCH_KEY, '[]');
    const result: string[] = JSON.parse(data as string);
    return result;
  }
}