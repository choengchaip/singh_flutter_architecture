import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/mocks/products/best_seller_products.dart';
import 'package:singh_architecture/mocks/products/new_arrival_products.dart';
import 'package:singh_architecture/mocks/products/products.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class CartRepository extends BaseDataRepository<CartModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  late CartModel mockData;

  CartRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options) {
    this.mockData = CartModel(
      Id: "c01",
      Products: [],
      Total: 0,
    );
    this.dataSC.add(this.mockData);
  }

  bool get isAllSelected {
    bool s = true;

    if (this.mockData.Products.length == 0) {
      return false;
    } else {
      for (int i = 0; i < this.mockData.Products.length; i++) {
        if (!this.mockData.Products[i].isSelected) {
          s = false;
        }
      }
    }

    return s;
  }

  Future<void> mockFetch() async {
    CartModel cart = this.mockData;
    cart.Total = 0;

    await TimeHelper.sleep();

    for (int i = 0; i < cart.Products.length; i++) {
      cart.Products[i].Total =
          cart.Products[i].Quantity * cart.Products[i].Price;
      if (cart.Products[i].isSelected) {
        cart.Total += cart.Products[i].Total;
      }
    }

    this.mockData = cart;
    this.dataSC.add(this.mockData);
  }

  Future<void> mockAddToCart(String productID, {int quantity: 1}) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      Map<String, dynamic> raw = [
        ...mockProducts,
        ...mockBestSellerProducts,
        ...mockNewArrivalProducts
      ].firstWhere((p) => productID == p["product_id"]);

      CartProductModel product = CartProductModel.fromJson(raw);
      CartProductModel? cartProduct;
      int? cpIndex;

      for (int i = 0; i < this.mockData.Products.length; i++) {
        if (this.mockData.Products[i].Id == product.Id) {
          cartProduct = this.mockData.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex == null) {
        cartProduct = product;
        cartProduct.Quantity = quantity;
        this.mockData.Products.add(cartProduct);
      } else {
        this.mockData.Products[cpIndex].Quantity += quantity;
      }
      this.dataSC.add(this.mockData);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> mockRemoveToCart(String productID) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      Map<String, dynamic> raw = [
        ...mockProducts,
        ...mockBestSellerProducts,
        ...mockNewArrivalProducts
      ].firstWhere((p) => productID == p["product_id"]);

      CartProductModel product = CartProductModel.fromJson(raw);
      int? cpIndex;

      for (int i = 0; i < this.mockData.Products.length; i++) {
        if (this.mockData.Products[i].Id == product.Id) {
          if (this.mockData.Products[i].Quantity <= 1) {
            this.mockData.Products.removeAt(i);
            this.dataSC.add(this.mockData);
            break;
          }

          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        this.mockData.Products[cpIndex].Quantity -= 1;
        this.dataSC.add(this.mockData);
      }

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> selectProduct(String id) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      CartProductModel? cartProduct;
      int? cpIndex;
      for (int i = 0; i < this.mockData.Products.length; i++) {
        if (id == this.mockData.Products[i].Id) {
          cartProduct = this.mockData.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        cartProduct!.isSelected = true;
        this.mockData.Products[cpIndex] = cartProduct;
        this.dataSC.add(this.mockData);
      }

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> unSelectProduct(String id) async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      CartProductModel? cartProduct;
      int? cpIndex;
      for (int i = 0; i < this.mockData.Products.length; i++) {
        if (id == this.mockData.Products[i].Id) {
          cartProduct = this.mockData.Products[i];
          cpIndex = i;
          break;
        }
      }

      if (cpIndex != null) {
        cartProduct!.isSelected = false;
        this.mockData.Products[cpIndex] = cartProduct;
        this.dataSC.add(this.mockData);
      }

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> selectAllProduct() async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      for (int i = 0; i < this.mockData.Products.length; i++) {
        this.mockData.Products[i].isSelected = true;
      }
      this.dataSC.add(this.mockData);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> unSelectAllProduct() async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      for (int i = 0; i < this.mockData.Products.length; i++) {
        this.mockData.Products[i].isSelected = false;
      }
      this.dataSC.add(this.mockData);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> mockCheckout() async {
    this.toLoadingStatus();

    try {
      await TimeHelper.sleep();

      this.mockData.Products.removeWhere((cp) => cp.isSelected);
      this.dataSC.add(this.mockData);

      await mockFetch();

      this.toLoadedStatus();
    } catch (e) {
      super.alertError(e);
      this.toErrorStatus(e);
    }
  }
}
