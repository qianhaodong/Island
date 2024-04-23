import { SwipeRefresher } from '@ohos.arkui.advanced.SwipeRefresher';
import { getHotBookList } from '../api/book';
import { BookList } from '../components/BookList';
import { BookSearch } from '../components/BookSearch'
import { SearchResult } from '../components/SearchResult';
import { BookItemType } from '../models';
import { StoreManager } from '../utils/store';

@Component
struct Book {
  @State searchFocus: boolean = false;
  @State hotBookList: BookItemType[] = [];
  @State query: string = '';
  @State isLoading: boolean = false;

  async aboutToAppear() {
    // this.isLoading = true;

    // 获取热门书籍缓存
    this.hotBookList = StoreManager.getHotBookList();

    // 请求热门书籍接口数据
    getHotBookList()
      .then((res: BookItemType[]) => {
        this.hotBookList = res;

        // 更新热门书籍缓存
        StoreManager.setHotBookList(res);
      })
  }

  build() {
    Column() {
      BookSearch({
        query: this.query,
        searchFocus: this.searchFocus
      })

      Scroll() {
        Column() {
          // 数据加载中...
          if (this.isLoading) {
            SwipeRefresher({
              content: '',
              isLoading: this.isLoading
            })
          } else {
            if (!this.searchFocus) {
              Column() {
                Image($r('app.media.decorate_icon'))
                  .width(54)
                  .height(16)
                  .objectFit(ImageFit.Fill)
                  .margin({ top: 16 })

                BookList({
                  bookList: this.hotBookList
                })
              }
            } else {
              SearchResult({
                query: this.query
              })
            }
          }
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f9f9f9')
  }
}

export { Book }