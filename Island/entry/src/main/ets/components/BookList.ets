import { BookItemType } from '../models'
import { BookItem } from './BookItem'

@Component
struct BookList {
  @Prop bookList: BookItemType[] = []

  build() {
    Flex({
      justifyContent: FlexAlign.SpaceBetween,
      wrap: FlexWrap.Wrap
    }) {
      ForEach(this.bookList, (item: BookItemType) => {
        BookItem({ bookItem: item })
      })
    }
    .width('100%')
    .padding({ top: 16, left: 48, right: 48 })
  }
}

export { BookList }