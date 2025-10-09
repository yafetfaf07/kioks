import { model, Schema, Types } from 'mongoose';

const orderProductSchema = new Schema({
  oid: {
    type: Types.ObjectId,
    required: true,
    ref: 'Order',
  },



  createdAt: {
    type: Date,
    default: Date.now,
  },
});

type Order = {
  oid: Types.ObjectId;

  createdAt: Date;
};

export default model<Order>('OrderProduct', orderProductSchema);
