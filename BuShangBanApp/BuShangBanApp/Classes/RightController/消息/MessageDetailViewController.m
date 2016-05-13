//
//  MessageDetailViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/5/12.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "UIImage+Extension.h"
#import "MessageModel.h"
#import "CellFrameModel.h"
#import "MessageCell.h"

@interface MessageDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{

    NSMutableArray *_cellFrameDatas;
    UITableView *_chatView;

    
    
    UIButton *_textButton;
    
    UILabel *_timeLabel;
    
    UILabel *_messageLabel;
    
    UIImageView *avarImageView;
}

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBarWithTitle:self.titles];
    self.view.backgroundColor=COLOR(249, 249, 249);
    [self loadData];
    [self addChatView];
}

- (void)loadData
{
    _cellFrameDatas =[NSMutableArray array];
    
    
    
//    NSURL *dataUrl = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
//    NSArray *dataArray = [NSArray arrayWithContentsOfURL:dataUrl];
//    for (NSDictionary *dict in dataArray) {
        MessageModel *message = [MessageModel messageModelWithDict:self.dataDic];
        CellFrameModel *lastFrame = [_cellFrameDatas lastObject];
        CellFrameModel *cellFrame = [[CellFrameModel alloc] init];
        message.showTime = ![message.time isEqualToString:lastFrame.message.time];
        cellFrame.message = message;
        [_cellFrameDatas addObject:cellFrame];
//    }
}


#pragma mark - tableView的数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellFrameDatas.count;
}

- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.cellFrame = _cellFrameDatas[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellFrameModel *cellFrame = _cellFrameDatas[indexPath.row];
    return cellFrame.cellHeght;
}



- (void)addChatView
{
    self.view.backgroundColor = COLOR(249, 249, 249);
    UITableView *chatView = [[UITableView alloc] init];
    chatView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height );
    chatView.backgroundColor =  COLOR(249, 249, 249);

    chatView.delegate = self;
    chatView.dataSource = self;
    chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    chatView.allowsSelection = NO;
//    [chatView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    _chatView = chatView;
    
    [self.view addSubview:chatView];
}
/*
-(void)createMainView{

    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setText:SafeForString(self.timeString)];
    [self.view addSubview:_timeLabel];
    [_timeLabel setFrame:CGRectMake(162*kDefaultBiLi, 44, 90*kDefaultBiLi, 10)];
    
    _messageLabel = [[UILabel alloc] init];
    [_messageLabel setText:SafeForString(self.messageString)];
    [_messageLabel setFrame:CGRectMake(60*kDefaultBiLi+12, 64+14, (kScreenWidth-124)*kDefaultBiLi-24, 14)];
    [_messageLabel setFont:[UIFont systemFontOfSize:12]];
    [_messageLabel setTextColor:[UIColor blackColor]];
    
    _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_textButton setTitle:self.messageString forState:UIControlStateNormal];
//    [_textButton.titleLabel setTextColor:[UIColor blackColor]];
//    [_textButton.titleLabel setText:self.messageString];
    _textButton.frame = CGRectMake(60*kDefaultBiLi, 64, (kScreenWidth-124)*kDefaultBiLi, 40);
    
    [_textButton setBackgroundImage:[UIImage resizeWithImageName:@"messageImage"] forState:UIControlStateNormal];
    [_textButton setTitle:self.messageString forState:UIControlStateNormal];
//    [_textButton.titleLabel setTextColor:[UIColor blackColor]];

    [self.view addSubview:_textButton];
    [self.view addSubview:_messageLabel];

}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
