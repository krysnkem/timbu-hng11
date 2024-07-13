const String imageBaseUrl = 'https://api.timbu.cloud/images';
const String getProductsUrl =
    'https://api.timbu.cloud/products?organization_id=7a17b44b6b38405fb040f888b70dc60e&Appid=4SKI80I2653OKTX&Apikey=1c812655d54040979a5fcbeff508278020240712163708200529';
// 'https://api.timbu.cloud/products?organization_id=c734118fdb4940558aab13b7717b165d&Appid=FGD9F10JBBSSC8H&Apikey=da7850c27c9f43d2aad875524469ab8620240708194640676742';
String getProductByIdUrl(String id) =>
    'https://api.timbu.cloud/products/$id?organization_id=c734118fdb4940558aab13b7717b165d&Appid=FGD9F10JBBSSC8H&Apikey=da7850c27c9f43d2aad875524469ab8620240708194640676742';
