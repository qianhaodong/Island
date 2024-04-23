import { BookCommentItem } from '../models';
import { promptAction } from '@kit.ArkUI';

@CustomDialog
struct CommentDialog {
  @Prop commentList: BookCommentItem[] = [];
  @State inputValue: string = '';
  controller: CustomDialogController;

  cancel: () => void = () => {}
  confirm: (value: string) => void = () => {}

  build() {
    Column() {
      Row() {
        Text('取消')
          .fontColor('#999')
          .onClick(() => {
            this.controller.close();
            this.cancel();
          })
        Text('确定')
          .onClick(() => {
            if (this.inputValue === '') {
              promptAction.showToast({
                message: '请输入短评内容',
                bottom: '50%'
              });
              return;
            }

            this.confirm(this.inputValue);
            this.controller.close();
            this.inputValue = '';
          })
      }
      .width('100%')
      .height(48)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .border({
        color: '#f1f1f1',
        width: {
          bottom: 1
        }
      })

      Column({ space: 16 }) {
        if (this.commentList.length) {
          Scroll() {
            Row({ space: 10 }) {
              ForEach(this.commentList, (item: BookCommentItem, index) => {
                Text(item.content)
                  .fontSize(12)
                  .fontColor('#666')
                  .backgroundColor(index === 0 ? '#FFFADD' : index === 1 ? '#EFFAFF' : '#f7f7f7')
                  .borderRadius(2)
                  .padding({ top: 6, right: 12, bottom: 6, left: 12 })
              })
            }
            .padding({ left: 16, right: 16 })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
        }

        TextInput({ text: $$this.inputValue, placeholder: '请输入您的短评，可输入12字' })
          .maxLength(12)
          .height(40)
          .placeholderColor('#aaa')
          .backgroundColor('#f5f5f5')
          .margin({ left: 16, right: 16 })
      }
      .width('100%')
      .padding({ top: 20, bottom: 20 })
    }
    .width('100%')
    .backgroundColor(Color.White)
  }
}

export { CommentDialog }