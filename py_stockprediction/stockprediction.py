# Import
import tensorflow as tf
import numpy as np
import pandas as pd
from pip._vendor.distlib.compat import raw_input
from sklearn.preprocessing import MinMaxScaler
import matplotlib.pyplot as plt
import csv

spreadold = 0.00030
spread = 0.030 # trading a GBPJPY pair
# Import data
data = pd.read_csv('data.csv', chr(9)) # mt5 bars data

data = data.drop("<DATE>", 1).drop("<TIME>", 1)
c = 0

# Dimensions of dataset
n = data.shape[0]
p = data.shape[1]

# Make data a np.array
data = data.values

# Training and test data
train_start = 0
train_end = int(np.floor(0.8*n))
test_start = train_end + 1
test_end = n
data_train = data[np.arange(train_start, train_end), :]
data_test = data[np.arange(test_start, test_end), :]
# for line in data_train:
#         line[0] = str(float(line[0]) + spread)
#         line[1]= str(float(line[1]) +spread)
#         line[2] = str(float(line[2]) + spread)
#         line[3]= str(float(line[3]) + spread)
#
# for line in data_test:
#         line[0] = str(float(line[0]) + spread)
#         line[1]= str(float(line[1]) + spread)
#         line[2] = str(float(line[2]) + spread)
#         line[3]= str(float(line[3]) + spread)

# Scale data
scaler = MinMaxScaler(feature_range=(-1, 1))
# scaler.fit(data_train)
# scaler.fit(data_train_t1)
# data_train = scaler.transform(data_train)
# data_test = scaler.transform(data_test)
# data_train_t1 = scaler.transform(data_train_t1)
# data_test_t1 = scaler.transform(data_test_t1)

# Build X and y (x is input data and y is expected output)
X_train = data_train[:, :4]  # instant T, prendre open high low close
y_train = data_train[1:, 3]  # t+1, prendre à partir de 1 et suivants
y_train = np.insert(y_train, -1, data_train[-1, 3], 0)  # dupliquer la premiere entree pour avoir le même nombre dentrees en entree et sortie
X_test = data_test[:, :4]  # idem ici mais pour les données de test
y_test = data_test[1:, 3]
y_test = np.insert(y_test, -1, data_test[-1, 3], 0)

# Number of informations in training data row
n_stocks = 4

# Neurons
n_neurons_1 = 1024
n_neurons_2 = 512
n_neurons_3 = 256
n_neurons_4 = 128

# Session
net = tf.InteractiveSession()

# Placeholder
X = tf.placeholder(dtype=tf.float32, shape=[None, n_stocks])
Y = tf.placeholder(dtype=tf.float32, shape=[None])

# Initializers
sigma = 1
weight_initializer = tf.variance_scaling_initializer(mode="fan_avg", distribution="uniform", scale=sigma)
bias_initializer = tf.zeros_initializer()

# Hidden weights
W_hidden_1 = tf.Variable(weight_initializer([n_stocks, n_neurons_1]))
bias_hidden_1 = tf.Variable(bias_initializer([n_neurons_1]))
W_hidden_2 = tf.Variable(weight_initializer([n_neurons_1, n_neurons_2]))
bias_hidden_2 = tf.Variable(bias_initializer([n_neurons_2]))
W_hidden_3 = tf.Variable(weight_initializer([n_neurons_2, n_neurons_3]))
bias_hidden_3 = tf.Variable(bias_initializer([n_neurons_3]))
W_hidden_4 = tf.Variable(weight_initializer([n_neurons_3, n_neurons_4]))
bias_hidden_4 = tf.Variable(bias_initializer([n_neurons_4]))

# Output weights
W_out = tf.Variable(weight_initializer([n_neurons_4, 1]))
bias_out = tf.Variable(bias_initializer([1]))

# Hidden layer
hidden_1 = tf.nn.relu(tf.add(tf.matmul(X, W_hidden_1), bias_hidden_1))
hidden_2 = tf.nn.relu(tf.add(tf.matmul(hidden_1, W_hidden_2), bias_hidden_2))
hidden_3 = tf.nn.relu(tf.add(tf.matmul(hidden_2, W_hidden_3), bias_hidden_3))
hidden_4 = tf.nn.relu(tf.add(tf.matmul(hidden_3, W_hidden_4), bias_hidden_4))

# Output layer (transpose!)
out = tf.transpose(tf.add(tf.matmul(hidden_4, W_out), bias_out))

# Cost function
mse = tf.reduce_mean(tf.squared_difference(out, Y))

# Optimizer
opt = tf.train.AdamOptimizer().minimize(mse)

# Init
net.run(tf.global_variables_initializer())

# Setup plot

# fig = plt.figure()# plt.ylim(100, 140)
# ax1 = fig.add_subplot(111)
# line1, = ax1.plot(y_test)
# line2, = ax1.plot(y_test * 0.5)
# plt.show()

# Fit neural net
batch_size = 50
mse_train = []
mse_test = []

# Run
epochs = 24
for e in range(epochs):

    # Shuffle training data
    shuffle_indices = np.random.permutation(np.arange(len(y_train)))
    X_train = X_train[shuffle_indices]
    y_train = y_train[shuffle_indices]

    # Minibatch training, par paquet de x lignes
    for i in range(0, len(y_train) // batch_size):
        start = i * batch_size
        batch_x = X_train[start:start + batch_size]
        batch_y = y_train[start:start + batch_size]
        # Run optimizer with batch
        net.run(opt, feed_dict={X: batch_x, Y: batch_y})

        # Show progress
        if np.mod(i, 50) == 0:
            # MSE train and test
            mse_train.append(net.run(mse, feed_dict={X: X_train, Y: y_train}))
            mse_test.append(net.run(mse, feed_dict={X: X_test, Y: y_test}))
            print('MSE Train: ', mse_train[-1])
            print('MSE Test: ', mse_test[-1])
            # Prediction
            pred = net.run(out, feed_dict={X: X_test})
            print('prediction: ', pred[-1])
            # line2.set_ydata(pred)
            # plt.title('Epoch ' + str(e) + ', Batch ' + str(i))
            # plt.pause(0.01)


prediction = pred[-1][-1]
current = X_test[-1][3]
print('current ', current)
print('prediction', prediction)

if (prediction > current):
    print('it will go up ', current, ' prediction ', prediction)
else:
    print('it will go down ', current, ' prediction ', prediction)

print('pips to earn ', abs(prediction - current))
if abs(prediction - current) > spread:
    print('go trade ', prediction)

    print('pips to earn ', abs(prediction - current))
else:
    print('no trade, margin is not enough to cover the spread')

# measure performance
successCount = 0
failCount = 0
pipsEarned = 0
pipsLost = 0
c = 0
for predValue in pred[0]:
    curClose = X_test[c, 3]  # cur close at t
    curTargetClose = y_test[c]  # the value at t+1 which was to predict
    diffPips = abs(curClose - curTargetClose)
    rightWay = False
    # first the prediction has to be accurate, predicted value is less than current close, we're going down,
    # predicted value is >= the value to predict
    if (predValue < curClose and predValue >= curTargetClose) or (predValue >= curClose and predValue < curTargetClose) :
        rightWay = True

    if diffPips > spread:
        if rightWay:
            successCount += 1
            pipsEarned += diffPips
        else:
            failCount += 1
            pipsLost += diffPips

    c += 1

print("successCount ", successCount)
print("failCount", failCount)
print("pipsEarned", pipsEarned)
print("pipsLost", pipsLost)
raw_input()