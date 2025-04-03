<template>
    <table class="table table-striped table-hover mt-5">
        <thead>
            <tr>
                <th>Registro_ANS</th>
                <th>CNPJ</th>
                <th>Razao_Social</th>
                <th>Nome_Fantasia</th>
                <th>Modalidade</th>
                <th>Logradouro</th>
                <th>Numero</th>
                <th>Complemento</th>
                <th>Bairro</th>
                <th>Cidade</th>
                <th>UF</th>
                <th>CEP</th>
                <th>DDD</th>
                <th>Telefone</th>
                <th>Fax</th>
                <th>Endereco_Eletronico</th>
                <th>Representante</th>
                <th>Cargo_Representante</th>
                <th>Regiao_de_Comercializacao</th>
                <th>Data_Registro_ANS</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(operadora, index) in content" :key="index">
                <td>{{ operadora.Registro_ANS }}</td>
                <td>{{ operadora.CNPJ }}</td>
                <td>{{ operadora.Razao_Social }}</td>
                <td>{{ operadora.Nome_Fantasia }}</td>
                <td>{{ operadora.Modalidade }}</td>
                <td>{{ operadora.Logradouro }}</td>
                <td>{{ operadora.Numero }}</td>
                <td>{{ operadora.Complemento }}</td>
                <td>{{ operadora.Bairro }}</td>
                <td>{{ operadora.Cidade }}</td>
                <td>{{ operadora.UF }}</td>
                <td>{{ operadora.CEP }}</td>
                <td>{{ operadora.DDD }}</td>
                <td>{{ operadora.Telefone }}</td>
                <td>{{ operadora.Fax }}</td>
                <td>{{ operadora.Endereco_Eletronico }}</td>
                <td>{{ operadora.Representante }}</td>
                <td>{{ operadora.Cargo_Representante }}</td>
                <td>{{ operadora.Regiao_de_Comercializacao }}</td>
                <td>{{ operadora.Data_Registro_ANS }}</td>
            </tr>
        </tbody>
    </table>
</template>

<script>
export default {
    props: ['content'],
}
</script>