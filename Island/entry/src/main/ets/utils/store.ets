import { preferences } from '@kit.ArkData'
import { BookItemType, ClassicType } from '../models';

const SEARCH_KEY = 'SEARCH_KEY';
const CLASSIC_LATEST = 'CLASSIC_LATEST';
const HOT_BOOK_LIST = 'HOT_BOOK_LIST';

export class StoreManager {
  static context: Context

  static getStore(context: Context = StoreManager.context) {
    const store = preferences.getPreferencesSync(context, { name: 'store_cache' });
    return store;
  }

  // 缓存搜索历史
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

  // 缓存最新一期期刊
  static async setClassicLatest(data: ClassicType) {
    const store = StoreManager.getStore();
    store.putSync(CLASSIC_LATEST, JSON.stringify(data));
    await store.flush();
  }

  static getClassicLatest() {
    const store = StoreManager.getStore();
    const data = store.getSync(CLASSIC_LATEST, 'null');
    const result: ClassicType = JSON.parse(data as string);
    return result;
  }

  // 缓存热门书籍
  static async setHotBookList(data: BookItemType[]) {
    const store = StoreManager.getStore();
    store.putSync(HOT_BOOK_LIST, JSON.stringify(data));
    await store.flush();
  }

  static getHotBookList() {
    const store = StoreManager.getStore();
    const data = store.getSync(HOT_BOOK_LIST, '[]');
    const result: BookItemType[] = JSON.parse(data as string);
    return result;
  }
}