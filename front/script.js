document.addEventListener('DOMContentLoaded', () => {
  const carrinho = [];


  const sidebar = document.createElement('div');
  sidebar.id = 'carrinho-sidebar';
  sidebar.innerHTML = `
      <div class="sidebar-content">
          <h2>Itens no Carrinho</h2>
          <div class="carrinho-itens"></div>
          <div class="carrinho-total">
              <h3>Total: <span id="total-carrinho">R$0,00</span></h3>
          </div>
          <div class="metodo-pagamento">
              <h3>Selecione o Método de Pagamento</h3>
              <label>
                  <input type="radio" name="metodo" value="Débito"> Débito
              </label>
              <label>
                  <input type="radio" name="metodo" value="Crédito"> Crédito
              </label>
              <label>
                  <input type="radio" name="metodo" value="Dinheiro"> Dinheiro
              </label>
          </div>
          <div class="sidebar-footer">
              <button id="finalizar-pedido">Finalizar Pedido</button>
              <button id="fechar-sidebar">Fechar</button>
          </div>
      </div>
  `;
  document.body.appendChild(sidebar);

 
  const atualizarContadorCarrinho = () => {
      const contador = document.getElementById('contador-carrinho');
      const totalItens = carrinho.reduce((acc, item) => acc + item.quantidade, 0);
      contador.textContent = totalItens;
  };

  
  const atualizarCarrinho = () => {
      const carrinhoItens = document.querySelector('.carrinho-itens');
      const totalElement = document.getElementById('total-carrinho');
      carrinhoItens.innerHTML = '';

      if (carrinho.length === 0) {
          carrinhoItens.innerHTML = '<p>O carrinho está vazio.</p>';
          totalElement.textContent = 'R$0,00';
      } else {
          let total = 0;

          carrinho.forEach((item, index) => {
              total += item.preco * item.quantidade;

              const itemDiv = document.createElement('div');
              itemDiv.classList.add('carrinho-item');
              itemDiv.innerHTML = `
                  <span>${item.nome} - R$${(item.preco * item.quantidade).toFixed(2)}</span>
                  <div class="quantidade-controle">
                      <button class="diminuir" data-index="${index}">-</button>
                      <span>${item.quantidade}</span>
                      <button class="aumentar" data-index="${index}">+</button>
                  </div>
              `;
              carrinhoItens.appendChild(itemDiv);
          });

          totalElement.textContent = `R$${total.toFixed(2)}`;

          document.querySelectorAll('.aumentar').forEach((botao) => {
              botao.addEventListener('click', (event) => {
                  const index = event.target.getAttribute('data-index');
                  carrinho[index].quantidade++;
                  atualizarCarrinho();
                  atualizarContadorCarrinho(); 
              });
          });

          document.querySelectorAll('.diminuir').forEach((botao) => {
              botao.addEventListener('click', (event) => {
                  const index = event.target.getAttribute('data-index');
                  if (carrinho[index].quantidade > 1) {
                      carrinho[index].quantidade--;
                  } else {
                      carrinho.splice(index, 1); 
                  }
                  atualizarCarrinho();
                  atualizarContadorCarrinho(); 
              });
          });
      }

      atualizarContadorCarrinho(); 
  };

  // Finalizar Pedido
  const finalizarPedido = () => {
      if (carrinho.length === 0) {
          alert('Seu carrinho está vazio!');
          return;
      }

      const metodoSelecionado = document.querySelector('input[name="metodo"]:checked');
      if (!metodoSelecionado) {
          alert('Por favor, selecione um método de pagamento!');
          return;
      }
      const metodoPagamento = metodoSelecionado.value;

      const total = carrinho.reduce((acc, item) => acc + item.preco * item.quantidade, 0).toFixed(2);
      const pedidoDetalhes = carrinho.map((item) => ({
          nome: item.nome,
          quantidade: item.quantidade,
          preco: item.preco,
      }));

      const pedido = {
          itens: pedidoDetalhes,
          total,
          metodoPagamento,
      };

      fetch('https://hamburgueria-full-stack.onrender.com', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(pedido),
      })
      .then((response) => response.text())
      .then((resultado) => {
          alert('Pedido finalizado com sucesso!');
          console.log('Resposta do backend:', resultado);
          carrinho.length = 0; 
          atualizarCarrinho();
          sidebar.classList.remove('open');
      })
      .catch((error) => {
          console.error('Erro ao enviar pedido:', error);
          alert('Erro ao finalizar pedido. Tente novamente.');
      });
  };

  // Eventos para abrir e fechar a sidebar
  document.querySelector('.bi-cart').addEventListener('click', () => {
      atualizarCarrinho();
      sidebar.classList.add('open');
  });

  document.getElementById('fechar-sidebar').addEventListener('click', () => {
      sidebar.classList.remove('open');
  });

  document.getElementById('finalizar-pedido').addEventListener('click', finalizarPedido);

  
  document.querySelectorAll('.pedir').forEach((botao) => {
      botao.addEventListener('click', (event) => {
          const produtoNome = botao.closest('.info').querySelector('h3').textContent;
          const precoTexto = botao.closest('.info').querySelector('h4 span').textContent.replace('R$', '');
          const produtoExistente = carrinho.find((item) => item.nome === produtoNome);

          if (produtoExistente) {
              produtoExistente.quantidade++;
          } else {
              const produto = {
                  nome: produtoNome,
                  preco: parseFloat(precoTexto),
                  quantidade: 1,
              };
              carrinho.push(produto);
          }

          atualizarCarrinho();
          atualizarContadorCarrinho(); 

          // Exibe o aviso
          const aviso = document.createElement('div');
          aviso.classList.add('aviso');
          aviso.textContent = 'Pedido adicionado!';
          document.body.appendChild(aviso);
          setTimeout(() => aviso.remove(), 2000);
      });
  });
});