[ [ 'test1', [ 'track', [ [ 'pch', [ [ 'filterTrack_1_1', [ 'timeDispersion', 0.01164090285194, 'winSize', 0.14246835443038 ] ], [ 'mod1', [ 'freq', 5, 'mul', 1, 'add', 0 ] ], [ 'mod2', [ 'phase', 0, 'mul', 1, 'add', 0 ] ], [ 'mod3', [ 'freq', 5, 'mul', 1, 'add', 0 ] ] ], [ [ 'filterTrack_1_1', [ 'pitchRatio', [ 'mod1', 'lfn1', [ -12.0, 12.0 ], [ 'freq', 5, 'mul', 1, 'add', 0 ], nil, 1, 0, nil, nil, nil, nil ] ] ], [ 'filterTrack_1_1', [ 'pitchDispertion', [ 'mod2', 'sin', [ 0.0099999999999999, 2.01, 'exp' ], [ 'phase', 0, 'mul', 1, 'add', 0 ], nil, 1, 0, nil, nil, nil, nil ] ] ], [ 'mod2', [ 'freq', [ 'mod3', 'lfn1', [ 1.0, 10.0 ], [ 'freq', 5, 'mul', 1, 'add', 0 ], nil, 1, 0, nil, nil, nil, nil ] ] ] ] ], [ 'harm', [ [ 'filterTrack_1_2', [ 'pitchRatio2', 1.5, 'pitchRatio3', 1.4, 'pitchRatio4', 1.3, 'vol1', 1.5, 'vol2', 1.4, 'vol3', 1.3, 'vol4', 1.2, 'pitchDispertion1', 0.4, 'pitchDispertion2', 0.3, 'pitchDispertion3', 0.2, 'pitchDispertion4', 0.1, 'timeDispersion1', 0.0004, 'timeDispersion2', 0.0003, 'timeDispersion3', 0.0002, 'timeDispersion4', 0.0001, 'lag1', 0.1, 'lag2', 0.1, 'lag3', 0.1, 'lag4', 0.1, 'winSize1', 0.02, 'winSize2', 0.02, 'winSize3', 0.02, 'winSize4', 0.02 ] ], [ 'mod5', [ 'freq', 1, 'phase', 0, 'mul', 1, 'add', 0 ] ] ], [ [ 'filterTrack_1_2', [ 'pitchRatio1', [ 'mod5', 'sin', [ 0.25, 6.0 ], [ 'freq', 1, 'phase', 0, 'mul', 1, 'add', 0 ], nil, 1, 0, nil, nil, nil, nil ] ] ] ] ] ] ] ], [ 'testRev2', [ 'master', [ [ 'convrev1', [ [ 'filterMaster_1_1', [ 'mix', 1.0 ], nil, [ 'convrev', 'ortf_s2r2', 2048 ] ] ], nil ], [ 'sclip', [ [ 'filterMaster_1_2', [ 'vol', 0 ], nil, nil ] ], nil ] ] ] ], [ 'testRev1', [ 'master', [ [ 'convrev1', [ [ 'filterMaster_1_1', [ 'mix', 0.4, 'alpha', -0.001, 'adjVol', 1 ], nil, [ 'convrev', 'ortf_s2r2', 2048 ] ] ], nil ], [ 'fds1', [ [ 'filterMaster_1_2', [ 'mix', 0.4, 'alpha', -0.001, 'adjVol', 1 ], nil, nil ] ], nil ], [ 'sclip', [ [ 'filterMaster_1_3', [ 'vol', 0 ], nil, nil ] ], nil ] ] ] ] ]