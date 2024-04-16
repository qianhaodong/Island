import { getHotBookList } from '../api';
import { BookList } from '../components/BookList';
import { BookSearch } from '../components/BookSearch'
import { SearchResult } from '../components/SearchResult';
import { BookItemType } from '../models';

@Component
struct Book {
  @State searchResultShow: boolean = false;
  @State hotBookList: BookItemType[] = [];

  async aboutToAppear() {
    this.hotBookList = await getHotBookList();
  }

  build() {
    Column() {
      BookSearch()

      Scroll() {
        if (!this.searchResultShow) {
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
          SearchResult()
        }
      }
      .width('100%')
      .layoutWeight(1)
      // .backgroundColor('rgba(0,0,0,0.4)')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f9f9f9')
  }
}

export { Book }