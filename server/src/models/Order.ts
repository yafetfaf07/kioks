import { model, Schema, Types } from 'mongoose';

const orderSchema = new Schema({
  uid: {
    type: Types.ObjectId,
    required: true,
    ref: 'User',
  },
  product: [
    {
      pid: {
        type: Types.ObjectId,
        ref: 'Product',
        
      },

      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  did: {
    type: Types.ObjectId,
    required: true,
    ref: 'DeliverPersonnel',
  },
  createdAt: {
    type:  Date,
    default: Date.now,
  },
});

type Order = {
  _id: Types.ObjectId;
  uid: Types.ObjectId;
  product:[{
    pid:Types.ObjectId,
    quantity:number
  }]
  did: Types.ObjectId;
  createdAt: Date;

};

export default model<Order>('Order', orderSchema);
