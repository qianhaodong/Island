import { BookCommentItem, BookLikeStatus } from '../models'
import { CommentDialog } from './CommentDialog';
import { Stars } from './Stars'
import { promptAction } from '@kit.ArkUI';

@Component
struct Comment {
  @Prop bookId: number = -1;
  @Prop likeStatus: BookLikeStatus | null = null;
  @Prop itemType: number = 0;
  @Link commentList: BookCommentItem[];

  // 自定义弹窗
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CommentDialog({
      commentList: this.commentList,
      confirm: (value) => { this.confirm(value) }
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true
  })

  // 在自定义组件即将析构销毁时将 dialogController 置空
  aboutToDisappear() {
    this.dialogController = null;
  }

  updateBookLikeStatus: () => void = () => {};
  updateBookShortComment: () => void = () => {};

  confirm(value: string) {
    promptAction.showToast({
      message: '评论成功',
      bottom: '50%',
    });
    // 新增短评
    this.commentList.unshift({
      content: value,
      nums: 1,
    });

    /*const params: Record<string, string | number> = {
      "book_id": this.bookId,
      "content": value,
    };
    addBookShortComment(params)
      .then(() => {
        promptAction.showToast({
          message: '评论成功',
          bottom: '50%',
        });
        // 更新数据
        this.updateBookShortComment();
      });*/
  }

  build() {
    Row() {
      Row({ space: 5 }) {
        Image($r('app.media.write_icon'))
          .width(12)
          .height(12)

        TextInput({ placeholder: '留下你的短评~' })
          .maxLength(12)
          .layoutWeight(1)
          .height('100%')
          .padding(0)
          .backgroundColor(Color.Transparent)
          .fontSize(14)
          .placeholderFont({
            size: 14
          })
          .enabled(false)
      }
      .width(200)
      .height(27)
      .padding({ left: 10, right: 10 })
      .border({
        color: Color.Black,
        width: 1
      })
      .borderRadius(27)
      .onClick(() => {
        if (this.dialogController !== null) {
          this.dialogController.open();
        }
      })

      Row({ space: 10 }) {
        Stars({
          itemId: this.likeStatus?.id,
          itemType: this.itemType,
          likeStatus: !!this.likeStatus?.like_status,
          favNums: this.likeStatus?.fav_nums,
          updateData: () => {
            this.updateBookLikeStatus();
          }
        })

        Image($r('app.media.share_icon'))
          .width(14)
          .height(14)
      }
    }
    .width('100%')
    .height(43)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#fff')
    .border({
      color: '#eee',
      width: {
        top: 1
      }
    })
  }
}

export { Comment }