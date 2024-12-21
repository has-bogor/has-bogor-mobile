import 'package:flutter/material.dart';
import 'package:has_bogor/screens/promo/promo_model.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;
  final bool isSuperuser;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAddStore;
  final Function(String)? onRemoveStore;

  const PromoCard({
    Key? key,
    required this.promo,
    required this.isSuperuser,
    this.onEdit,
    this.onDelete,
    this.onAddStore,
    this.onRemoveStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Kode: ${promo.kode}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Potongan: ${promo.potongan}%'),
                Text('Masa Berlaku: ${promo.masaBerlaku} hari'),
                Text('Minimal Transaksi: Rp${promo.minimalTransaksi.toStringAsFixed(0)}'),
              ],
            ),
            trailing: isSuperuser ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ) : null,
          ),
          if (promo.tokoTerkait.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toko Terkait:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  ...promo.tokoTerkait.map((store) => ListTile(
                    title: Text(store['name'] ?? ''),
                    trailing: isSuperuser ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onRemoveStore?.call(store['name']),
                    ) : null,
                  )),
                ],
              ),
            ),
          ],
          if (isSuperuser) Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: onAddStore,
              icon: Icon(Icons.add),
              label: Text('Tambah Toko'),
            ),
          ),
        ],
      ),
    );
  }
}